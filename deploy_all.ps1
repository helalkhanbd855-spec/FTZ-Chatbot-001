# =====================================
# FTZ Chatbot Auto Deploy Script
# Author: Helal Khan (helalkhanbd855-spec)
# Version: 1.0
# =====================================

Write-Host "🚀 Starting FTZ Chatbot Deployment..." -ForegroundColor Cyan

# Step 1: Go to your project folder
Set-Location "C:\Users\Helal khan\Downloads\FTZ_Chatbot_2_Custom 03"

# Step 2: Add and commit all changes
git add .
git commit -m "Auto-deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" --allow-empty

# Step 3: Push changes to GitHub
Write-Host "💛 Pushing code to GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push failed! Check your internet or GitHub credentials." -ForegroundColor Red
    exit 1
}

# Step 4: Trigger Render auto-deploy (optional step)
# NOTE: Render auto-deploys automatically if enabled on the dashboard.
Write-Host "🌐 Triggering Render auto-deploy..." -ForegroundColor Green
Start-Sleep -Seconds 10

# Step 5: Show success message and open site
$renderUrl = "https://ftz-chatbot.onrender.com"   # <-- replace with your actual Render URL
Write-Host "✅ FTZ Chatbot successfully deployed!" -ForegroundColor Green
Write-Host "=== FTZ Chatbot deployed successfully! ===" -ForegroundColor Green

# Optional: Open in browser
Start-Process $renderUrl
