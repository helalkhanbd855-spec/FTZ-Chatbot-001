Capacitor packaging for FTZ Chatbot 2
-------------------------------------
1) Install Node.js (16+).
2) cd capacitor
3) npm install
4) npm run copy:pwa   # copies ../frontend-pwa into ./www
5) npx cap init ftz-chatbot-2 "FTZ Chatbot 2"
6) npx cap add android && npx cap add ios
7) npx cap copy
8) npx cap open android   # Android Studio
   npx cap open ios       # Xcode (macOS)

Assets:
- Use resources/splash-1024.png as base splash.
- For full adaptive icons & splashes: npx @capacitor/assets generate
