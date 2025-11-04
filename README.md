# FTZ Chatbot 2 — PWA + Flask + Capacitor (Custom Theme)

**Theme color:** `#0A84FF`  
**Logo:** Included ✅

---

### 📁 Folder Structure

- **frontend-pwa/** → PWA UI (Ask Me Anything styled, typing effect, caching)
- **backend-flask/** → Flask API (`/chat`)
- **capacitor/** → Package PWA into Android/iOS

---

### 🧑‍💻 Run Locally

1. **Backend:** See `backend-flask/README.md`
2. **Frontend:** Open `frontend-pwa/home.html` (or serve via static server)  
   👉 Set backend URL with: `?api=http://127.0.0.1:5000`

---

### 📱 Capacitor (Android/iOS)

- Steps inside `capacitor/README.md`
- Generate assets:
  ```bash
  npx @capacitor/assets generate
