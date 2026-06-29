-- Fix for admin records save failure
-- The error is caused because the `records` table does not have an INSERT policy for the admin.
-- Or because the policy requires a specific condition we couldn't meet.
-- Run this in your Supabase SQL Editor:

-- Drop any existing conflicting policies if needed (optional)
-- DROP POLICY IF EXISTS "Admin can insert records" ON public.records;

-- Create an INSERT policy allowing the admin to insert records
CREATE POLICY "Admin can insert records" ON public.records
FOR INSERT
TO authenticated
WITH CHECK (
  auth.jwt() ->> 'email' = 'admin@dentalclinic.com' -- or admin@dental.com depending on your actual admin email
);

-- Additionally, verify if the admin can select all records:
-- CREATE POLICY "Admin can view all records" ON public.records FOR SELECT TO authenticated USING (auth.jwt() ->> 'email' = 'admin@dentalclinic.com');
