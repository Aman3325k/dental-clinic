# MEMORY.md — Project State

## Facts (never override without confirmation)
Project: dental-clinic
Supabase URL: https://rsqwngcssozglzokequw.supabase.co
Supabase key: sb_publishable_XkMSH4IM1_rMTMu1fcUEAg_AOJVczg3
Hosting: Vercel
Live URL: https://dental-clinic-iota-black.vercel.app
GitHub: Aman3325k/dental-clinic
Admin email: admin@dentalclinic.com
Astro output: static
Tailwind: v4 (Vite plugin)

## Database Schema (live in Supabase)
patients: id (uuid, PK, refs auth.users), full_name, phone, date_of_birth, address, created_at
appointments: id (uuid PK), patient_id (refs patients), appointment_date, appointment_time, treatment_type, status (pending/confirmed/cancelled/completed), notes, created_at
records: id (uuid PK), patient_id, diagnosis, treatment_done, next_visit, created_by (default admin), created_at

## RLS Active
patients: auth.uid() = id
appointments: auth.uid() = patient_id
records: select only for auth.uid() = patient_id

## What is built
Phase 1 (Supabase): ✅ Complete
Phase 2 (Scaffold): ✅ Complete — astro.config.mjs uses Tailwind v4 as Vite plugin
Phase 3 (Layouts + components + home page): ✅ Complete
Phase 4 (Login, signup, contact, 404): ✅ Complete
Phase 5 (Patient dashboard + booking): ✅ Complete
Phase 6 (Admin dashboard): ✅ Complete
Phase 7 (SEO & Vercel): ✅ Complete

## Decisions Made
Admin = hardcoded email check (practice project)
No guest booking
Static output only
No git add .

## Known Issues Resolved
- Admin Dashboard UI polished (stats row layout and table header)
- Phone input country code selection added to signup
- Admin stats DOM initialization bug fixed
- Admin UI (index, patients, records) completely redesigned (Vercel minimalist style)