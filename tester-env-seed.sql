-- Deterministic tester-env seed for Leantime.
-- Theme: Northstar product team preparing a checkout reliability launch.

SET @seed_now = '2026-06-01 09:00:00';

DELETE FROM zp_timesheets WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_comment WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_tickethistory WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_tickets WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_sprints WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_relationuserproject WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_projects WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_user WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_clients WHERE id BETWEEN 100 AND 199;
DELETE FROM zp_note WHERE id BETWEEN 100 AND 199;

INSERT INTO zp_clients (id, name, street, zip, city, state, country, phone, internet, published, age, email, modified) VALUES
  (100, 'Northstar Digital', '410 Market Street', 94105, 'San Francisco', 'CA', 'USA', '+1 415 555 0198', 'https://northstar.example', 1, 7, 'ops@northstar.example', @seed_now);

INSERT INTO zp_user (id, username, password, firstname, lastname, phone, profileId, lastlogin, status, expires, role, session, sessiontime, wage, hours, description, clientId, notifications, createdOn, source, jobTitle, jobLevel, department, modified) VALUES
  (100, 'maria.product@tester-env.local', '', 'Maria', 'Chen', '', '', '2026-05-31 16:10:00', 'A', NULL, '30', '', '', 0, 40, 'Product lead for checkout reliability.', 100, 1, '2026-05-01 09:00:00', 'tester-env seed', 'Product Lead', 'Lead', 'Product', @seed_now),
  (101, 'devon.engineering@tester-env.local', '', 'Devon', 'Patel', '', '', '2026-05-30 11:20:00', 'A', NULL, '20', '', '', 0, 40, 'Backend engineer focused on payment APIs.', 100, 1, '2026-05-01 09:10:00', 'tester-env seed', 'Backend Engineer', 'Senior', 'Engineering', @seed_now),
  (102, 'ivy.design@tester-env.local', '', 'Ivy', 'Morgan', '', '', '2026-05-29 14:45:00', 'A', NULL, '20', '', '', 0, 32, 'UX designer for billing and onboarding.', 100, 1, '2026-05-01 09:20:00', 'tester-env seed', 'Product Designer', 'Staff', 'Design', @seed_now);

INSERT INTO zp_projects (id, name, clientId, details, state, hourBudget, dollarBudget, active, menuType, psettings, parent, type, start, end, created, modified, sortIndex) VALUES
  (100, 'Checkout Reliability Launch', 100, 'Hardening payment, receipt, and fulfillment workflows before the June release.', 1, '240', 0, 1, NULL, NULL, NULL, 'project', '2026-05-20 09:00:00', '2026-06-28 17:00:00', '2026-05-20 09:00:00', @seed_now, 1),
  (101, 'Mobile Onboarding Refresh', 100, 'Improve first-run activation and empty states for the mobile funnel.', 1, '120', 0, 1, NULL, NULL, NULL, 'project', '2026-05-10 09:00:00', '2026-07-12 17:00:00', '2026-05-10 09:00:00', @seed_now, 2),
  (102, 'Archived Vendor Portal Migration', 100, 'Completed migration retained for history and archived-list assertions.', 1, '80', 0, 0, NULL, NULL, NULL, 'project', '2026-03-01 09:00:00', '2026-04-15 17:00:00', '2026-03-01 09:00:00', @seed_now, 3);

INSERT INTO zp_relationuserproject (id, userId, projectId, wage, projectRole) VALUES
  (100, 1, 100, 0, 'owner'), (101, 100, 100, 0, 'manager'), (102, 101, 100, 0, 'editor'), (103, 102, 100, 0, 'editor'),
  (104, 1, 101, 0, 'owner'), (105, 100, 101, 0, 'manager'), (106, 102, 101, 0, 'editor'),
  (107, 1, 102, 0, 'owner');

INSERT INTO zp_sprints (id, projectId, name, startDate, endDate, modified) VALUES
  (100, 100, 'Sprint 12 - Payment Stabilization', '2026-05-25 09:00:00', '2026-06-07 17:00:00', @seed_now),
  (101, 100, 'Sprint 13 - Release Readiness', '2026-06-08 09:00:00', '2026-06-21 17:00:00', @seed_now),
  (102, 101, 'Sprint 4 - Guided Setup', '2026-06-01 09:00:00', '2026-06-14 17:00:00', @seed_now);

INSERT INTO zp_tickets (id, projectId, headline, description, acceptanceCriteria, date, dateToFinish, priority, status, userId, component, version, dependingTicketId, editFrom, editTo, editorId, planHours, hourRemaining, type, production, staging, storypoints, sprint, sortindex, kanbanSortIndex, tags, milestoneid, modified) VALUES
  (100, 100, 'Milestone: Checkout beta launch', 'Beta release checkpoint for payment reliability work.', '', '2026-05-20 09:00:00', '2026-06-21 17:00:00', '2', 4, 100, 'Release', '2026.06', NULL, '2026-05-20 09:00:00', '2026-06-21 17:00:00', 100, 0, 0, 'milestone', 0, 1, 0, 101, 100, 100, 'release,beta', NULL, @seed_now),
  (101, 100, 'Reconcile duplicate payment webhook events', 'Make checkout idempotent when the payment provider retries webhooks.', 'Duplicate webhook deliveries create one order, one receipt, and one audit entry.', '2026-05-21 09:00:00', '2026-06-03 17:00:00', '1', 4, 101, 'Payments API', '2026.06', NULL, NULL, NULL, 101, 16, 6, 'bug', 0, 1, 8, 100, 101, 101, 'payments,reliability', 100, @seed_now),
  (102, 100, 'Add receipt resend action to order detail', 'Support can resend a receipt without asking engineering to replay the job.', 'Order detail shows a Resend receipt action and success message for eligible paid orders.', '2026-05-22 09:00:00', '2026-06-06 17:00:00', '2', 3, 100, 'Support Tools', '2026.06', NULL, NULL, NULL, 100, 10, 10, 'story', 0, 0, 5, 100, 102, 102, 'support,receipts', 100, @seed_now),
  (103, 100, 'Blocked: tax service timeout fallback', 'Fallback copy and retry policy are waiting on finance approval.', 'When the tax API times out, checkout shows clear retry copy and preserves the cart.', '2026-05-23 09:00:00', '2026-06-05 17:00:00', '2', 1, 101, 'Tax Service', '2026.06', NULL, NULL, NULL, 101, 12, 12, 'task', 0, 0, 5, 100, 103, 103, 'blocked,tax', 100, @seed_now),
  (104, 100, 'Verify fulfillment event appears in customer timeline', 'Timeline needs a visible event when the warehouse accepts the order.', 'Customer timeline lists Fulfillment accepted with timestamp and shipment reference.', '2026-05-24 09:00:00', '2026-06-10 17:00:00', '3', 2, 102, 'Timeline', '2026.06', NULL, NULL, NULL, 102, 8, 2, 'task', 0, 1, 3, 101, 104, 104, 'fulfillment,timeline', 100, @seed_now),
  (105, 100, 'Document checkout incident runbook', 'Create a concise support and engineering runbook for payment incidents.', 'Runbook covers detection, customer messaging, rollback, and escalation owner.', '2026-05-25 09:00:00', '2026-06-12 17:00:00', '4', 0, 100, 'Operations', '2026.06', NULL, NULL, NULL, 100, 6, 0, 'task', 0, 0, 2, 101, 105, 105, 'runbook,ops', 100, @seed_now),
  (106, 101, 'Prototype guided setup progress checklist', 'Show users what remains before the account is ready.', 'Checklist tracks profile, first project, notification preferences, and invitation steps.', '2026-05-18 09:00:00', '2026-06-14 17:00:00', '3', 4, 102, 'Onboarding', '2026.06', NULL, NULL, NULL, 102, 14, 7, 'story', 0, 1, 8, 102, 106, 106, 'mobile,onboarding', NULL, @seed_now),
  (107, 101, 'Empty-state copy review for mobile dashboard', 'Replace generic empty copy with action-oriented setup guidance.', 'Dashboard empty state includes one primary action and explains expected value.', '2026-05-19 09:00:00', '2026-06-08 17:00:00', '4', 3, 102, 'Mobile UX', '2026.06', NULL, NULL, NULL, 102, 5, 5, 'task', 0, 0, 2, 102, 107, 107, 'copy,mobile', NULL, @seed_now),
  (108, 102, 'Retire legacy vendor SSO toggle', 'Completed cleanup item kept in archived project history.', 'Legacy toggle removed from settings and migration notes published.', '2026-03-10 09:00:00', '2026-04-01 17:00:00', '5', -1, 1, 'Vendor Portal', '2026.04', NULL, NULL, NULL, 1, 3, 0, 'task', 1, 1, 1, NULL, 108, 108, 'archived,vendor', NULL, @seed_now),
  (109, 100, 'Audit expired-card error copy', 'Checkout and billing disagree on the expired-card message; align the copy and the retry guidance before the next release.', 'Checkout and billing show the same expired-card message with retry guidance.', '2026-05-26 09:00:00', '2026-06-24 17:00:00', '4', 0, 102, 'Checkout', '2026.06', NULL, NULL, NULL, 102, 4, 0, 'task', 0, 0, 2, 101, 109, 109, 'checkout,copy', NULL, @seed_now);

INSERT INTO zp_comment (id, module, userId, commentParent, date, moduleId, text, status) VALUES
  (100, 'ticket', 100, 0, '2026-05-28 10:15:00', 101, 'Maria: Prioritize the webhook replay test before beta sign-off.', 'A'),
  (101, 'ticket', 101, 0, '2026-05-29 13:40:00', 103, 'Devon: Waiting on finance to confirm the fallback tax messaging.', 'A'),
  (102, 'ticket', 102, 0, '2026-05-30 09:25:00', 104, 'Ivy: Timeline event copy is ready for review with support.', 'A');

INSERT INTO zp_timesheets (id, userId, ticketId, workDate, hours, description, kind, invoicedEmpl, invoicedComp, rate, paid, modified) VALUES
  (100, 101, 101, '2026-05-27 09:00:00', 3.5, 'Webhook retry harness and duplicate payload fixture.', 'Development', 0, 0, '0', 0, @seed_now),
  (101, 100, 102, '2026-05-28 09:00:00', 1.25, 'Acceptance criteria and support workflow review.', 'Product', 0, 0, '0', 0, @seed_now),
  (102, 102, 104, '2026-05-29 09:00:00', 2.0, 'Timeline event copy and fulfillment handoff notes.', 'Design', 0, 0, '0', 0, @seed_now);

INSERT INTO zp_note (id, userId, title, description) VALUES
  (100, 1, 'Checkout release QA notes', 'Stable seed note: verify kanban columns, sprint filters, comments, and time logs for the Checkout Reliability Launch.'),
  (101, 100, 'Support launch checklist', 'Confirm receipt resend, tax timeout fallback, fulfillment timeline, and incident runbook before beta.');

INSERT INTO zp_tickethistory (id, userId, ticketId, changeType, changeValue, dateModified) VALUES
  (100, 101, 101, 'status', '4', '2026-05-28 15:00:00'),
  (101, 101, 103, 'status', '1', '2026-05-29 16:00:00'),
  (102, 100, 105, 'status', '0', '2026-05-30 11:30:00');

-- Complete first-run onboarding for the seeded admin so the task-creation
-- welcome modal ("Welcome to Leantime" / "Let's go") never opens after login.
-- The company flag is set explicitly because installs that finish through the
-- userInvite flow do not write it themselves.
INSERT INTO zp_settings (`key`, `value`) VALUES ('companysettings.completedOnboarding', 'true')
  ON DUPLICATE KEY UPDATE `value` = 'true';
INSERT INTO zp_settings (`key`, `value`) VALUES ('user.1.firstLoginCompleted', 'true')
  ON DUPLICATE KEY UPDATE `value` = 'true';

-- Persist the admin's dismissal of the returning-user dashboard tour modal so
-- login lands on a usable workspace instead of a one-time onboarding overlay.
-- Written as the same PHP-serialized structure the UI stores via
-- updateUserSettings('modals', 'home', true).
UPDATE zp_user SET settings = 'a:1:{s:6:"modals";a:1:{s:4:"home";b:1;}}' WHERE id = 1;
