# Agent Guidelines & Project Rules

This document outlines the strict rules and constraints for any AI agents operating on this codebase.

## 1. Architectural Constraints
- **Routing**: **Never use SPA routing** (e.g., `react-router-dom`). This is a Multi-Page Application (MPA) built with Astro. All navigation must use standard HTML `<a>` tags and `window.location.href`.
- **Output Mode**: The project is strictly configured for static site generation (`output: 'static'` in `astro.config.mjs`). Do not attempt to add SSR adapters or server-side endpoints (`/api/*.ts`).
- **Data Fetching**: All data fetching, authentication, and mutation must happen on the client-side within `<script>` tags using the Supabase client.

## 2. Styling Rules
- **Tailwind CSS**: Tailwind CSS is mandatory for all styling.
- **No Inline Styles**: Never use inline styles (`style="..."`). Convert all existing inline styles to Tailwind utility classes.
- **Responsiveness**: All layouts (especially Admin layouts) must be mobile-responsive. Do not use fixed-pixel widths that break small screens (e.g., `width: 240px`).

## 3. Security Rules
- **Environment Variables**: All client-side environment variables must be prefixed with `PUBLIC_` (e.g., `PUBLIC_SUPABASE_URL`).
- **No Hardcoded Secrets**: Never hardcode API keys, service roles, emails, passwords, or placeholders in the source code.
- **No Accidental Commits**: Never commit `.env`, `.env.local`, or `.env.production` files.
- **SEO & Indexing**: Ensure protected routes (Admin, Dashboard, Book) are excluded from `sitemap-index.xml` and include `noindex` meta tags where appropriate.

## 4. Code Quality
- **Error Handling**: Follow the strategies outlined in `ERRORS.md`. Always display user-facing error states and log the full error object to the console.
- **Empty States**: Always handle empty states gracefully (e.g., "No appointments found" instead of an empty white table).
- **Quality Standard**: Execute at a "god level". Leave no UX friction points, misalignments, or dead links.
