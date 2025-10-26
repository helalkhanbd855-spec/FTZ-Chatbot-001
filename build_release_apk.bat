@echo off
cd /d "%~dp0\capacitor\android"
echo ==============================
echo 🚀 Building Release APK...
echo ==============================
gradlew clean assembleRelease
echo.
echo ✅ Done! Find your APK here:
echo app\build\outputs\apk\release\app-release.apk
pause
