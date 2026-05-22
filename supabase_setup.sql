-- ================================================================
  -- GAROMS-TECH — Supabase Setup SQL
  -- Coller ce SQL dans: Supabase Dashboard > SQL Editor > New Query
  -- ================================================================

  -- 1. TABLE NEWSLETTER (abonnés)
  CREATE TABLE IF NOT EXISTS newsletter (
    id          BIGSERIAL PRIMARY KEY,
    email       TEXT NOT NULL UNIQUE,
    source      TEXT DEFAULT 'index_top',
    created_at  TIMESTAMPTZ DEFAULT NOW()
  );

  -- Index pour recherche rapide par email
  CREATE INDEX IF NOT EXISTS idx_newsletter_email ON newsletter(email);

  -- Autoriser INSERT public (sans auth) via anon key
  ALTER TABLE newsletter ENABLE ROW LEVEL SECURITY;

  CREATE POLICY "allow_public_insert" ON newsletter
    FOR INSERT TO anon WITH CHECK (true);

  CREATE POLICY "allow_service_select" ON newsletter
    FOR SELECT TO service_role USING (true);

  -- 2. TABLE CONTACTS (formulaire contact)
  CREATE TABLE IF NOT EXISTS contacts (
    id          BIGSERIAL PRIMARY KEY,
    nom         TEXT,
    email       TEXT,
    telephone   TEXT,
    service     TEXT,
    message     TEXT,
    status      TEXT DEFAULT 'nouveau',
    created_at  TIMESTAMPTZ DEFAULT NOW()
  );

  ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;

  CREATE POLICY "allow_public_insert_contacts" ON contacts
    FOR INSERT TO anon WITH CHECK (true);

  CREATE POLICY "allow_service_select_contacts" ON contacts
    FOR SELECT TO service_role USING (true);

  -- 3. TABLE PAGE_VIEWS (analytics optionnel)
  CREATE TABLE IF NOT EXISTS page_views (
    id          BIGSERIAL PRIMARY KEY,
    page        TEXT,
    referrer    TEXT,
    ua          TEXT,
    created_at  TIMESTAMPTZ DEFAULT NOW()
  );

  ALTER TABLE page_views ENABLE ROW LEVEL SECURITY;

  CREATE POLICY "allow_public_insert_pv" ON page_views
    FOR INSERT TO anon WITH CHECK (true);

  -- ================================================================
  -- FIN — Exécuter ce script une seule fois dans Supabase SQL Editor
  -- ================================================================
  