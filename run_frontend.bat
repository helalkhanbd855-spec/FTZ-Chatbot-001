@echo off
echo ======================================
echo 🚀 Running FTZ Chatbot 2 Frontend (PWA)
echo ======================================

REM Go to frontend-pwa folder
cd /d "%~dp0frontend-pwa"

REM Install dependencies
echo 📦 Installing dependencies...
call npm install

REM Start development server
echo 🌍 Starting development server at http://localhost:3000
call npm start

pause
