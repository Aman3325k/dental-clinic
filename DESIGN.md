# DESIGN.md — SmileCare Dental Design System

## Color System
| Token | Value | Usage |
|---|---|---|
| `--color-bg` | `#FFFFFF` | Page backgrounds |
| `--color-surface` | `#F8FAFC` | Cards, panels, auth page bg |
| `--color-border` | `#E2E8F0` | All borders |
| `--color-text-primary` | `#0F172A` | Headings, strong labels |
| `--color-text-body` | `#334155` | Body copy |
| `--color-text-muted` | `#94A3B8` | Placeholders, helper text |
| `--color-accent` | `#0EA5E9` | Primary CTA, links, active states |
| `--color-accent-dark` | `#0284C7` | Hover state for accent |
| `--color-success` | `#10B981` | Success banners |
| `--color-warning` | `#F59E0B` | Pending status |
| `--color-danger` | `#EF4444` | Destructive actions, error states |
| `--color-admin` | `#6366F1` | Admin accent (indigo) |

## Typography
| Role | Font | Weight |
|---|---|---|
| Display / headings | DM Sans | 700, 800 |
| Body | Inter | 400, 500, 600 |
| Timestamps, IDs, status codes | JetBrains Mono | 400, 500 |

## Component Style
- **Cards**: `bg-white border border-slate-200 rounded-xl shadow-sm`
- **Inputs**: `border border-slate-200 rounded-lg px-4 py-3 focus:ring-2 focus:ring-sky-500`
- **Primary button**: `bg-sky-500 hover:bg-sky-600 text-white rounded-lg px-5 py-3 font-medium`
- **Danger button**: `bg-red-500 hover:bg-red-600 text-white rounded-lg`
- **Ghost button**: `border border-slate-200 text-slate-700 hover:bg-slate-50 rounded-lg`
- **Status pill**: rounded-full, color-coded (pending=amber, confirmed=emerald, cancelled=red, completed=slate)
- **Modals**: `bg-slate-900/50` overlay, `bg-white rounded-xl shadow-xl p-6` card, centered via flex

## Admin Panel
- Sidebar: `bg-slate-900` with `text-slate-400` nav links, active = `bg-slate-800 text-white`
- Main content area: `bg-slate-50` with white cards
- Admin accent: indigo (`#6366F1`) for primary admin actions

## Project Info
- Admin email: admin@dental.com
- Supabase project: https://rsqwngcssozglzokequw.supabase.co
- Live URL: https://dental-clinic-iota-black.vercel.app
