@echo off
echo ==========================================
echo 🚀 FTZ Chatbot - Auto Build & Run on Emulator
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
npx cap sync android

REM Step 3: Build APK using Gradle
cd android
echo 🏗️ Building APK...
gradlew assembleDebug

REM Step 4: Install APK to Emulator
echo 📱 Installing on Emulator...
adb install -r app\build\outputs\apk\debug\app-debug.apk

REM Step 5: Launch App
echo ▶️ Launching App...
adb shell am start -n com.ftz.chatbot/.MainActivity

echo ==========================================
echo ✅ FTZ Chatbot Installed & Launched!
echo ==========================================
pause
