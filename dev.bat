@echo off
REM === FTZ Chatbot 2 Auto Dev Script (404 FIXED) ===

REM Root project path
set PROJECT_PATH=C:\Users\Helal khan\Downloads\FTZ_Chatbot_2_Custom 03

REM --- Start Backend ---
echo Starting Flask backend...
cd "%PROJECT_PATH%\backend-flask"
start cmd /k "python -m venv venv && call venv\Scripts\activate && pip install -r requirements.txt && python app.py"

REM --- Start Frontend ---
echo Starting PWA frontend...
cd "%PROJECT_PATH%\frontend-pwa"
start cmd /k "python -m http.server 8000"

REM --- Info ---
echo =======================================
echo Backend running at: http://127.0.0.1:5000
echo Frontend running at: http://127.0.0.1:8000/index.html?api=http://127.0.0.1:5000
echo =======================================
pause
