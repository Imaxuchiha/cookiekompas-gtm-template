# CookieKompas — GTM Template

This folder contains the **GTM Custom Template** that installs the Adsvantage
CookieKompas loader and sets Google Consent Mode v2 defaults from inside Google
Tag Manager.

> A Custom HTML tag also works, but cannot guarantee its execution order
> before Google tags fire. Use this template approach instead.

## Files

- `template.tpl` — single-file template you import into GTM.
  Adds a tag called **CookieKompas** that:
  1. Calls `gtag('consent', 'default', …)` with the EU/EEA/UK default-deny
     matrix the dashboard recommends.
  2. Injects the loader script with the provided **Website ID**.
- `field-permissions.md` — explains which GTM permissions the template uses
  (read data layer, inject script, send pixel).

## Importing into GTM

1. In GTM: **Templates → Tag Templates → New → ⋮ → Import** and select
   `template.tpl`.
2. After importing, go to **Tags → New → CookieKompas**.
3. Fill in the fields:
   - **Website ID** — your website's UUID from the dashboard (Installation page).
   - **Loader URL** — the `…/consent.js` URL shown in the dashboard.
   - **Region list** — comma-separated ISO codes the defaults apply to
     (defaults to `EU,EEA,GB`).
4. **Trigger**: choose **Consent Initialization — All Pages**. This is the
   only trigger that fires before user-data tags.
5. Submit the workspace.

## Testing

- Use **Tag Assistant** (`tagassistant.google.com`) and confirm:
  - `consent default` fires before any GA4/Ads tag.
  - The script tag `<script src="…/consent.js">` is injected.
- In the dashboard, open *Banner → Installation* and press *Verify*.
  You should see `banner_shown` or `consent_default_detected` within seconds.

## Publishing to the GTM Community Template Gallery

Getting listed makes the template searchable inside every GTM container
("Templates → Tag Templates → Search Gallery"). Google sources the gallery from
a **public GitHub repository** that has `template.tpl` in its **root**.

1. **Create a public repo** (e.g. `consent-hub-gtm-template`) and put these files
   in the root: `template.tpl`, `LICENSE` (Apache-2.0, included here) and a short
   `README.md`. (`metadata.yaml` can be hand-written from the sample here, but the
   next step generates it for you.)
2. **Import the template into your own GTM container** (you already have it under
   *Templates → Tag Templates*).
3. In the template editor, open the overflow menu **⋮ → "Add to Community
   Gallery"**, authorise GitHub, and select the repo from step 1. GTM commits a
   `metadata.yaml` and submits the listing.
4. Google reviews the submission. Once approved it shows up under **Search
   Gallery** for everyone.

**Tips for discoverability**
- Keep the `displayName` clear and keyword-rich, e.g. *"CookieKompas —
  Google Consent Mode v2"*.
- Add a brand logo (in the template's `___INFO___` brand block).
- A good `description` + the `UTILITY` and `PRIVACY` categories (already set) help
  it surface for "consent" / "consent mode" searches.
- The gallery requires the **Apache-2.0** license — it ships in this folder.

## Compliance reminder

The default consent matrix shipped with this template (`denied` for
ad/analytics, `granted` for security/functionality) reflects a
**default-deny** stance for EU/EEA/UK. It **requires legal validation** for
your specific use case before going live. See `docs/compliance-notes.md` in
the main repo.

> Sync: bij wijzigingen aan template.tpl ook apps/web/public/cookiekompas-gtm-template.tpl bijwerken (download-knop in dashboard).
