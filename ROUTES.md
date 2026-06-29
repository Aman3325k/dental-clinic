# Route Documentation

This document outlines the routing structure and permissions for the Dental Clinic application.

## Public Routes
These routes are accessible to anyone.
- `/` - Landing Page
- `/contact` - Contact Us (Form is mocked in static export)
- `/login` - Authentication Page (used by both patients and admins)
- `/signup` - Patient Registration
- `/forgot-password` - Password Recovery
- `/reset-password` - Password Reset

## Protected Patient Routes
These routes require authentication. Admins are redirected away from these routes.
- `/dashboard` - Patient Dashboard (Overview, past/upcoming appointments)
- `/book` - Appointment Booking Flow

## Protected Admin Routes
These routes require authentication AND the user's email must match `PUBLIC_ADMIN_EMAIL`.
- `/admin` - Admin Dashboard (Appointments Management)
- `/admin/patients` - Patient Directory
- `/admin/records` - Medical Records Management

## Security & SEO
- **robots.txt**: Blocks `/admin`, `/dashboard`, and `/book`.
- **Sitemap**: `astro.config.mjs` explicitly filters out all protected routes so they are not indexed by search engines.
- **Admin Layout**: Injects `<meta name="robots" content="noindex, nofollow" />` as defense-in-depth against unauthorized indexing.
- **Auth Guard**: Protected pages use Supabase `getSession()` and client-side `window.location.href` redirects to enforce access control.
