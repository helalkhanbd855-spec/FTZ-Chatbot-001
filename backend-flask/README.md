Run backend:
1) python -m venv venv
2) source venv/bin/activate   # or venv\Scripts\activate on Windows
3) pip install -r requirements.txt
4) python app.py   # http://127.0.0.1:5000

Point PWA to backend:
- Open: frontend-pwa/home.html?api=http://127.0.0.1:5000
- Or set once: localStorage.setItem('API_BASE','http://127.0.0.1:5000')
