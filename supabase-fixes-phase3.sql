-- Phase 3: Add ON DELETE CASCADE to foreign keys
-- This ensures that deleting a patient automatically deletes their appointments and records.

-- Drop existing constraints (Supabase default names are usually table_column_fkey)
ALTER TABLE public.appointments
  DROP CONSTRAINT IF EXISTS appointments_patient_id_fkey;

ALTER TABLE public.appointments
  ADD CONSTRAINT appointments_patient_id_fkey
  FOREIGN KEY (patient_id) REFERENCES public.patients(id)
  ON DELETE CASCADE;

ALTER TABLE public.records
  DROP CONSTRAINT IF EXISTS records_patient_id_fkey;

ALTER TABLE public.records
  ADD CONSTRAINT records_patient_id_fkey
  FOREIGN KEY (patient_id) REFERENCES public.patients(id)
  ON DELETE CASCADE;
