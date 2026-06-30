-- 1. Create the `profiles` table to store user roles
CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid REFERENCES auth.users ON DELETE CASCADE NOT NULL PRIMARY KEY,
  role text DEFAULT 'patient' NOT NULL
);

-- Ensure RLS is enabled on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- 2. Create a SECURITY DEFINER function to check for admin role safely (prevents infinite recursion)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
$$;

-- 3. Profile policies
-- Users can read their own profile
CREATE POLICY "Users can read own profile" ON public.profiles
  FOR SELECT TO authenticated USING (auth.uid() = id);

-- Admins can read all profiles
CREATE POLICY "Admins can read all profiles" ON public.profiles
  FOR SELECT TO authenticated USING (public.is_admin());

-- 4. Set the existing admin user's role to 'admin'
-- If they don't exist yet, this will safely do nothing.
INSERT INTO public.profiles (id, role)
SELECT id, 'admin'
FROM auth.users
WHERE email = 'admin@dental.com'
ON CONFLICT (id) DO UPDATE SET role = 'admin';

-- 5. Enable RLS on all tables
ALTER TABLE public.patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.records ENABLE ROW LEVEL SECURITY;

-- 6. Patients table policies
-- Patients can view and update their own patient record
CREATE POLICY "Patients can view own record" ON public.patients
  FOR SELECT TO authenticated USING (auth.uid() = id);
CREATE POLICY "Patients can update own record" ON public.patients
  FOR UPDATE TO authenticated USING (auth.uid() = id);
CREATE POLICY "Patients can insert own record" ON public.patients
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = id);

-- Admins can do everything on patients
CREATE POLICY "Admins can select all patients" ON public.patients
  FOR SELECT TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can insert all patients" ON public.patients
  FOR INSERT TO authenticated WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update all patients" ON public.patients
  FOR UPDATE TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can delete all patients" ON public.patients
  FOR DELETE TO authenticated USING (public.is_admin());

-- 7. Appointments table policies
-- Patients can view and create their own appointments
CREATE POLICY "Patients can view own appointments" ON public.appointments
  FOR SELECT TO authenticated USING (auth.uid() = patient_id);
CREATE POLICY "Patients can insert own appointments" ON public.appointments
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = patient_id);
CREATE POLICY "Patients can update own appointments" ON public.appointments
  FOR UPDATE TO authenticated USING (auth.uid() = patient_id);

-- Admins can do everything on appointments
CREATE POLICY "Admins can select all appointments" ON public.appointments
  FOR SELECT TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can insert all appointments" ON public.appointments
  FOR INSERT TO authenticated WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update all appointments" ON public.appointments
  FOR UPDATE TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can delete all appointments" ON public.appointments
  FOR DELETE TO authenticated USING (public.is_admin());

-- 8. Records table policies
-- Patients can view their own records
CREATE POLICY "Patients can view own records" ON public.records
  FOR SELECT TO authenticated USING (auth.uid() = patient_id);

-- Only Admins can insert/update/delete records
CREATE POLICY "Admins can select all records" ON public.records
  FOR SELECT TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can insert all records" ON public.records
  FOR INSERT TO authenticated WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update all records" ON public.records
  FOR UPDATE TO authenticated USING (public.is_admin());
CREATE POLICY "Admins can delete all records" ON public.records
  FOR DELETE TO authenticated USING (public.is_admin());
