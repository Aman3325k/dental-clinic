# Error Handling & Debugging

This document outlines the standard error handling strategies used across the application.

## Client-Side Error Handling
1. **Form Validation**: All forms use standard HTML5 validation attributes (`required`, `type="email"`, etc.) alongside custom JavaScript validation.
2. **Error Visibility**:
   - Supabase network errors or authentication failures must trigger a visible `<p class="text-red-500 hidden">` element.
   - Example pattern:
     ```javascript
     const errorEl = document.getElementById('error-msg');
     if (error) {
       console.error('Supabase Error:', error);
       errorEl.textContent = error.message;
       errorEl.classList.remove('hidden');
     }
     ```
3. **Button States**: Submit buttons must be disabled and show a loading state (e.g., "Signing in...", "Booking...") during async operations to prevent duplicate submissions.
4. **Console Logging**: All caught errors must be logged to the console via `console.error(error)` for debugging purposes. Do not swallow errors.

## Static Generation Constraints
- Since the application is built with Astro `output: 'static'`, there are no server-side API endpoints (`.ts` files in `/api`).
- All data mutation and fetching happens entirely on the client-side via the Supabase JS client.
- **Form Submissions**: Real endpoint forms (like Formspree) or backend API routes cannot be used natively without an external service. For example, the Contact form uses a mocked JS intercept to simulate success since there is no backend API to process it.
