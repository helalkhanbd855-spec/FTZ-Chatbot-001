@echo off
cd /d "%~dp0\capacitor\android"
echo ==============================
echo 🚀 Building Release AAB (Play Store)...
echo ==============================
gradlew clean bundleRelease
echo.
echo ✅ Done! Find your AAB here:
echo app\build\outputs\bundle\release\app-release.aab
pause
