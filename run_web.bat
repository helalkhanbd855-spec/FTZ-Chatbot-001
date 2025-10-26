@echo off
echo ================================
echo   Running FTZ Chatbot Web App
echo ================================

:: ঠিক ফোল্ডারে ঢুকছি
cd /d "%~dp0frontend-pwa"

:: প্রথমবার হলে dependencies install করবে
if not exist node_modules (
    echo Installing dependencies...
    npm install
)

:: এবার লোকাল সার্ভার চালু করবে 8000 পোর্টে
echo Starting server on http://localhost:8000
npx serve -l 8000

pause
