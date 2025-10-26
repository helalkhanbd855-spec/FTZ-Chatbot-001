#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./init_git.sh https://github.com/<user>/<repo>.git"
  exit 1
fi
git init
git add .
git commit -m "Initial FTZ Chatbot 2: custom theme + logo (PWA+Flask+Capacitor)"
git branch -M main
git remote add origin "$1"
git push -u origin main
