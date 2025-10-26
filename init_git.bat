@echo off
IF "%1"=="" (
  ECHO Usage: init_git.bat https://github.com/<user>/<repo>.git
  GOTO :EOF
)
git init
git add .
git commit -m "Initial FTZ Chatbot 2: custom theme + logo (PWA+Flask+Capacitor)"
git branch -M main
git remote add origin %1
git push -u origin main
ECHO Done.
