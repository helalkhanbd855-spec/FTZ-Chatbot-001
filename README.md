FTZ Chatbot 2 — PWA + Flask + Capacitor (Custom Theme)
=======================================================
Theme color: #0A84FF; Logo included.

Folders
- frontend-pwa/   -> PWA UI (Ask Me Anything styled, typing effect, caching)
- backend-flask/  -> Flask API (/chat)
- capacitor/      -> Package PWA into Android/iOS

Run locally
1) Backend: see backend-flask/README.md
2) Frontend: open frontend-pwa/index.html (or via static server). Point to backend with ?api=http://127.0.0.1:5000

Capacitor (Android/iOS)
- Steps inside capacitor/README.md
- For assets, run: npx @capacitor/assets generate

Deploy PWA (web)
- Host contents of frontend-pwa/ on HTTPS (Netlify, Vercel, Cloudflare Pages).
- Ensure backend is accessible via HTTPS and update API_BASE accordingly.

Play Store quick checklist
- Release AAB from Android Studio, App signing configured.
- Play Console: listing, privacy policy, content rating, screenshots.
- Internet permission (default) + any plugin permissions.
- VersionName/Code bump for updates.

App Store quick checklist
- Xcode Release build; bundle ID, version, signing set.
- App Store Connect: listing, screenshots, privacy details.
- ATS: use HTTPS; if HTTP needed, set NSAppTransportSecurity.
- TestFlight before submission recommended.

Security
- Never put secrets in frontend. Keep keys server-side and use HTTPS in production.
