@echo off
echo ==========================================
echo 🚀 FTZ Chatbot - Build & Run on Emulator
echo ==========================================

REM Step 1: Build frontend-pwa
cd /d "C:\Users\Helal khan\Downloads\FTZ_Chatbot_2_Custom 03\frontend-pwa"
echo 📦 Installing dependencies...
npm install
echo ⚡ Building PWA...
npm run build

REM Step 2: Copy build into capacitor/www
cd /d "C:\Users\Helal khan\Downloads\FTZ_Chatbot_2_Custom 03\capacitor"
echo 🔄 Copying PWA into capacitor/www...
npm run copy:pwa
npx cap copy

REM Step 3: Open Android project in Android Studio
echo 📱 Opening Android Studio...
npx cap open android

echo ✅ Done! Now run the app from Android Studio (▶ button).
pause
