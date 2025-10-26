@echo off
echo ================================
echo 📱 FTZ Chatbot - Build Script
echo ================================

REM --- Frontend build করা ---
cd frontend-pwa
npm run build
cd ..

REM --- Capacitor sync + Android ---
cd capacitor
echo 🔄 Syncing Android...
npx cap sync android
npx cap open android

REM --- Capacitor sync + iOS ---
echo 🔄 Syncing iOS...
npx cap sync ios
npx cap open ios

echo ================================
echo ✅ Build Done! Opened Android Studio & Xcode
echo ================================
pause
