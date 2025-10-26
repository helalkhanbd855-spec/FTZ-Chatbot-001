@echo off
echo ==============================
echo 🚀 FTZ Chatbot 2 Build & Install
echo ==============================

:: Step 1: Build frontend-pwa
echo [1/5] Building frontend-pwa...
cd frontend-pwa
call npm install
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Frontend build failed!
    pause
    exit /b %errorlevel%
)
cd ..

:: Step 2: Copy frontend build to capacitor/www
echo [2/5] Copying frontend build to capacitor/www...
call npm run copy:pwa
if %errorlevel% neq 0 (
    echo ❌ Copy step failed!
    pause
    exit /b %errorlevel%
)

:: Step 3: Capacitor sync
echo [3/5] Syncing Capacitor with Android...
cd capacitor
call npx cap sync android
if %errorlevel% neq 0 (
    echo ❌ Capacitor sync failed!
    pause
    exit /b %errorlevel%
)

:: Step 4: Build APK
echo [4/5] Building APK...
cd android
call gradlew assembleDebug
if %errorlevel% neq 0 (
    echo ❌ APK build failed!
    pause
    exit /b %errorlevel%
)

:: Step 5: Install on device
echo [5/5] Installing APK on connected device...
adb install -r app/build/outputs/apk/debug/app-debug.apk
if %errorlevel% neq 0 (
    echo ❌ Install failed! Make sure your device is connected and USB Debugging is ON.
    pause
    exit /b %errorlevel%
)

echo ✅ Done! FTZ Chatbot 2 installed on device!
pause
