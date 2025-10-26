@echo off
echo 🚀 Building Release APK...
cd capacitor\android
.\gradlew assembleRelease

echo ✅ Build Done!

set APK_PATH=app\build\outputs\apk\release\app-release.apk

if exist %APK_PATH% (
    echo 📱 Installing APK on connected device...
    adb install -r %APK_PATH%
    echo 🎉 Done! App installed successfully on your device.
) else (
    echo ❌ APK build failed. Check Gradle errors.
)
pause
