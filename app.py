from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # allow calls from PWA

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json() or {}
    msg = data.get('message','')
    if msg.strip() == '':
        reply = 'Say something and I will reply 🙂'
    elif 'timecard' in msg.lower():
        reply = 'Timecard feature coming soon. Tell me your hours and I will draft it.'
    elif 'hello' in msg.lower():
        reply = 'Hello! How can I help you today?'
    else:
        reply = f'You said: {msg}'
    return jsonify({'reply': reply})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
