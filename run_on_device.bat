@echo off
echo ==============================
echo 🚀 Running FTZ Chatbot 2 on Real Device
echo ==============================

REM 1) Frontend build check
if not exist frontend-pwa\package.json (
    echo ❌ ERROR: frontend-pwa not found!
    pause
    exit /b
)

cd frontend-pwa
echo 📦 Installing dependencies...
npm install
echo 🛠️ Building frontend...
npm run build
cd ..

REM 2) Copy build into capacitor/www
echo 📂 Copying frontend build into capacitor/www...
rmdir /s /q capacitor\www
mkdir capacitor\www
xcopy frontend-pwa\dist\* capacitor\www\ /E /H /C /I

REM 3) Sync with Capacitor
cd capacitor
npx cap sync android

REM 4) Run on real device
echo 📱 Installing on connected device...
npx cap run android --target=device
