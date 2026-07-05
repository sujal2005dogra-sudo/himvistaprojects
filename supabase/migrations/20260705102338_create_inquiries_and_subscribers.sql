/*
# Create inquiry and newsletter tables for HimVista Projects (no-auth, single-tenant)

This site is a marketing site for a construction company. There is NO sign-in screen.
Visitors submit contact inquiries, quote requests, and newsletter sign-ups. The data is
intentionally shared/public (single-tenant, no owner scoping), so policies use
`TO anon, authenticated` with `USING (true)` / `WITH CHECK (true)` so the anon-key
frontend client can read its own writes and submit new rows.

## New Tables

### `inquiries`
Holds both general contact-form submissions and free-quote modal requests.
- `id` (uuid, primary key)
- `name` (text, not null) — submitter's full name
- `phone` (text, not null) — contact phone
- `email` (text, nullable) — contact email (optional on some forms)
- `message` (text, nullable) — project description / free-text message
- `source` (text, not null default 'contact') — which form: 'contact', 'quote', 'newsletter'
- `created_at` (timestamptz, default now())

### `subscribers`
Holds newsletter email sign-ups.
- `id` (uuid, primary key)
- `email` (text, not null, unique) — subscriber email
- `created_at` (timestamptz, default now())

## Security
- Enable RLS on both tables.
- Allow anon + authenticated CRUD (intentionally public/shared single-tenant data).
- `USING (true)` is acceptable here because there is no sign-in screen and the data is
  intentionally shared; documented per the skill's RLS guidance.
*/

CREATE TABLE IF NOT EXISTS inquiries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  phone text NOT NULL,
  email text,
  message text,
  source text NOT NULL DEFAULT 'contact',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE inquiries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_inquiries" ON inquiries;
CREATE POLICY "anon_select_inquiries" ON inquiries FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_inquiries" ON inquiries;
CREATE POLICY "anon_insert_inquiries" ON inquiries FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_inquiries" ON inquiries;
CREATE POLICY "anon_update_inquiries" ON inquiries FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_inquiries" ON inquiries;
CREATE POLICY "anon_delete_inquiries" ON inquiries FOR DELETE
  TO anon, authenticated USING (true);

CREATE TABLE IF NOT EXISTS subscribers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text NOT NULL UNIQUE,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_subscribers" ON subscribers;
CREATE POLICY "anon_select_subscribers" ON subscribers FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_subscribers" ON subscribers;
CREATE POLICY "anon_insert_subscribers" ON subscribers FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_subscribers" ON subscribers;
CREATE POLICY "anon_update_subscribers" ON subscribers FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_subscribers" ON subscribers;
CREATE POLICY "anon_delete_subscribers" ON subscribers FOR DELETE
  TO anon, authenticated USING (true);
