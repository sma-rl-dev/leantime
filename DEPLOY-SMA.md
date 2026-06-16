# Leantime Deployment Notes

## Quick Start

```bash
./tester-env deploy    # Build image, start MySQL+app, install app wizard
./tester-env seed      # Populate with deterministic Northstar Digital seed data
./tester-env verify    # Check stable DB counts and HTTP-rendered seeded UI text
./tester-env reset     # Clean slate (stop containers, remove volume)
```

## URLs

- Local: `http://localhost:5080`
- Browser (MCP): `http://host.docker.internal:5080/`

## Credentials

- Admin: `admin@tester-env.local` / `TesterEnv123!`

## Architecture

- **App**: PHP 8.2 Apache, editable source mounted at `/var/www/html`
- **Database**: MySQL 8.4 with named volume `tester-env-leantime-mysql-data`
- **Port**: 5080

## Build

Source build with `./tester-env build` (or `deploy` which includes build):
- `composer install --no-dev`
- `npm install`
- `npx mix --production`
- `generateBlocklist.mjs`

Cold build ~10 min, image size ~3 GB.

## Seed Data (Northstar Digital)

3 projects, 9 tickets/tasks across New/Blocked/In Progress/Waiting/Done/Archived, 3 users, 3 sprints, 3 comments, 3 timesheets, 2 notes.

Stable visible names:
- Checkout Reliability Launch
- Mobile Onboarding Refresh
- Reconcile duplicate payment webhook events
- Blocked: tax service timeout fallback
- Document checkout incident runbook

## Browser Evidence

Browser-checker passed on 2026-06-16 at `http://host.docker.internal:5080/`:
- Login with admin@tester-env.local / TesterEnv123! accepted
- Dashboard shows "Hi Admin" with seeded task stats
- Projects dropdown lists Northstar Digital projects
- Checkout Reliability Launch dashboard shows company/background/milestone/team members
- Kanban shows seeded cards including Reconcile duplicate payment webhook events, Blocked: tax service timeout fallback, Verify fulfillment event appears in customer timeline, Document checkout incident runbook, Add receipt resend action to order detail
- Mobile Onboarding Refresh dashboard shows distinct seeded background and tasks

## Baseline

Upstream: `c589d54c72c7cbda5b0cc7c6da4a209cddff3eeb` (Leantime/leantime, master, v3.8.0, 2026-06-10)
Fork: `https://github.com/Smartesting/leantime`, branch `tester-env-baseline`

## Reset Path

`./tester-env reset` runs `docker compose -p tester-env-leantime down -v` — removes containers and the `tester-env-leantime-mysql-data` named volume. Re-deploy with `./tester-env deploy` completes full cycle in <2 min with cached image.
