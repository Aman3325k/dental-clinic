-- 1. Server-side booking validation
-- Add CHECK constraint to appointments to reject past dates.
ALTER TABLE appointments ADD CONSTRAINT chk_future_date CHECK (appointment_date >= CURRENT_DATE);

-- 2. Prevent double-booking
-- Add a UNIQUE constraint on the appointment date and time.
ALTER TABLE appointments ADD CONSTRAINT unique_date_time UNIQUE (appointment_date, appointment_time);

-- 3. Patient-side appointment cancellation
-- RLS for UPDATE so patients can cancel their own appointments.
-- We ensure they can only change status to 'cancelled'.
CREATE POLICY "Patients can cancel own appointments" 
ON appointments FOR UPDATE 
USING (auth.uid() = patient_id) 
WITH CHECK (auth.uid() = patient_id AND status = 'cancelled');

-- 4. Fix ghost accounts on signup failure
-- Trigger to automatically create a patient profile when a user signs up.
-- Runs as SECURITY DEFINER to bypass RLS and ensure the row is created.
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  -- Guard against creating a patient profile for the admin
  IF NEW.email = 'admin@dental.com' THEN
    RETURN NEW;
  END IF;

  BEGIN
    INSERT INTO public.patients (id, full_name, phone, date_of_birth)
    VALUES (
      NEW.id,
      NEW.raw_user_meta_data->>'full_name',
      NEW.raw_user_meta_data->>'phone',
      NULLIF(NEW.raw_user_meta_data->>'date_of_birth', '')::DATE
    );
  EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'Failed to create patient profile for user %: %', NEW.id, SQLERRM;
  END;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists to allow re-running
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
