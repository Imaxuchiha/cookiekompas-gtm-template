# Field permissions used by the template

The template requests three GTM sandbox permissions. Each is necessary; below
is why, so a reviewer in your GTM workspace can approve them confidently.

| Permission              | Why it's needed                                                        |
| ----------------------- | ---------------------------------------------------------------------- |
| `setDefaultConsentState` | To call `gtag('consent','default',…)` — the entire point of the tag.  |
| `injectScript`           | To inject `consent.js` from the URL the workspace owner provided.     |
| `dataLayer` (read+write) | The loader and the rest of GTM communicate through it.                |

The template does **not** request any of:

- Cookie read/write (the loader does that itself, in the browser, not through GTM).
- Network requests beyond the script injection.
- Reading user data fields.

If you tighten the **Inject script URLs** permission, allow at minimum the
hostname you use for `consent.js`.
