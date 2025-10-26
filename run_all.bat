@echo off
title 🌍📱 FTZ Chatbot - Full Automation
echo ==================================
echo     FTZ Chatbot - Build & Run All
echo ==================================

:: Step 0 - Python Path Fix (if needed)
set PYTHON_EXE=python
where %PYTHON_EXE% >nul 2>nul
if errorlevel 1 (
    echo ❌ Python not found in PATH!
    echo Please install Python and add it to PATH.
    pause
    exit /b
)

:: Step 1 - Start Backend Flask
echo [1/5] Starting Flask Backend...
start cmd /k "cd backend-flask && %PYTHON_EXE% app.py"

:: Step 2 - Start Frontend PWA (React/Vue)
echo [2/5] Starting Frontend PWA...
start cmd /k "cd frontend-pwa && npm install && npm start"

:: Step 3 - Build Web (PWA for dist)
echo [3/5] Building PWA for Capacitor...
cd frontend-pwa
npm run build
cd ..

:: Step 4 - Sync with Capacitor (Android + iOS)
echo [4/5] Syncing with Capacitor...
cd capacitor
npx cap sync
cd ..

:: Step 5 - Run Android App on Emulator
echo [5/5] Running Android App on Emulator...
cd capacitor/android
gradlew assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk
adb shell am start -n com.ftz.chatbot/.MainActivity
cd ../..

echo ==================================
echo ✅ Backend: http://127.0.0.1:5000
echo ✅ Frontend: http://localhost:3000
echo ✅ Android App Installed (emulator/device)
echo ✅ iOS App (open from Xcode if on macOS)
echo ==================================
pause
