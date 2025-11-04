from flask import Flask, request, jsonify
from flask_cors import CORS
import datetime
import os
from openpyxl import Workbook, load_workbook

app = Flask(__name__)
CORS(app)

# In-memory chat state per user
user_states = {}

# ---------- Helper Functions ----------

def get_time_greeting():
    hour = datetime.datetime.now().hour
    if 5 <= hour < 12:
        return "Good morning"
    elif 12 <= hour < 17:
        return "Good afternoon"
    elif 17 <= hour < 21:
        return "Good evening"
    else:
        return "Good night"

def save_to_excel(filename, headers, row_data):
    """Create or append a record into Excel."""
    file_exists = os.path.exists(filename)

    if file_exists:
        wb = load_workbook(filename)
        ws = wb.active
    else:
        wb = Workbook()
        ws = wb.active
        ws.append(headers)

    ws.append(row_data)
    wb.save(filename)

# ---------- Chatbot Logic ----------

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json() or {}
    msg = data.get('message', '').strip().lower()
    user = "Mr. Helal"
    greeting = get_time_greeting()
    reply = ""

    state = user_states.get(user, {"mode": None, "step": None, "data": {}})

    # ------------------- SITE UPDATE FLOW -------------------
    if state["mode"] == "site_update":
        if state["step"] == "ask_site":
            state["data"]["site_name"] = msg
            reply = "What job done today?"
            state["step"] = "ask_job"

        elif state["step"] == "ask_job":
            state["data"]["job_done"] = msg
            reply = "What balance remains?"
            state["step"] = "ask_balance"

        elif state["step"] == "ask_balance":
            state["data"]["balance"] = msg
            reply = "How many persons worked?"
            state["step"] = "ask_person"

        elif state["step"] == "ask_person":
            state["data"]["person_count"] = msg
            reply = "Any other update?"
            state["step"] = "ask_other"

        elif state["step"] == "ask_other":
            state["data"]["other_update"] = msg

            # ✅ Save to Excel
            now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            save_to_excel(
                "Site_Updates.xlsx",
                ["DateTime", "User", "Site", "Job Done", "Balance", "Persons", "Other Update"],
                [
                    now,
                    user,
                    state["data"].get("site_name", ""),
                    state["data"].get("job_done", ""),
                    state["data"].get("balance", ""),
                    state["data"].get("person_count", ""),
                    state["data"].get("other_update", "")
                ]
            )

            reply = (
                f"✅ Your site update has been submitted!\n\n"
                f"📅 Date: {now}\n"
                f"📍 Site: {state['data']['site_name'].capitalize()}\n"
                f"🧰 Job: {state['data']['job_done']}\n"
                f"📊 Balance: {state['data']['balance']}\n"
                f"👷 Persons: {state['data']['person_count']}\n"
                f"🗒️ Other: {state['data']['other_update']}\n\n"
                "Saved to Site_Updates.xlsx ✅"
            )

            # Reset memory
            user_states[user] = {"mode": None, "step": None, "data": {}}
        else:
            reply = "Let's start again. Which site?"
            state["step"] = "ask_site"

        user_states[user] = state
        return jsonify({'reply': reply})

    # ------------------- TIMECARD UPDATE FLOW -------------------
    if state["mode"] == "timecard_update":
        if state["step"] == "ask_time":
            # Example: "9 am to 6 pm"
            work_hours = msg
            now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            # ✅ Save to Excel
            save_to_excel(
                "Timecards.xlsx",
                ["DateTime", "User", "Work Hours"],
                [now, user, work_hours]
            )

            reply = (
                f"✅ Your timecard is submitted!\n\n"
                f"🕒 Work Hours: {work_hours}\n"
                f"📅 Date: {now}\n"
                "Saved to Timecards.xlsx ✅"
            )

            user_states[user] = {"mode": None, "step": None, "data": {}}
            return jsonify({'reply': reply})

    # ------------------- MAIN CHAT LOGIC -------------------
    if not msg:
        reply = "Please say something 🙂"

    elif any(word in msg for word in ["hi", "hello", "hey"]):
        reply = (
            f"{greeting}, {user}! 👋\n"
            "How can I help you today?\n"
            "আমি কি আপনাকে সাহায্য করতে পারি?\n"
            "আপনি কি কিছু জানতে চান নাকি কিছু আপডেট করতে চান?\n\n"
            "Type 'know' to learn about systems or 'update' to give new info."
        )

    elif "know" in msg or "jante" in msg:
        reply = (
            "Please choose what you want to know more about:\n"
            "1️⃣ Car Park Barrier Systems\n"
            "2️⃣ Wired Intrusion Alarm Systems\n"
            "3️⃣ Wireless Intrusion Alarm Systems\n"
            "4️⃣ Access Control Systems\n"
            "5️⃣ Alarm Panel\n"
            "6️⃣ Alarm System\n"
            "7️⃣ Network Cameras\n"
            "8️⃣ Digital Door Lock\n"
            "9️⃣ Sliding & Swing Auto Gate Systems\n"
            "🔟 Home Automation Systems\n"
            "11️⃣ Network Switches\n"
            "12️⃣ Turnstile Gate\n"
            "13️⃣ Audio & Video Intercom Systems"
        )

    elif "update" in msg:
        if "time" in msg:
            reply = "Please enter your work hours (e.g. '9 AM to 6 PM')."
            user_states[user] = {"mode": "timecard_update", "step": "ask_time", "data": {}}
        elif "site" in msg:
            reply = "Let's start your site update. Which site?"
            user_states[user] = {"mode": "site_update", "step": "ask_site", "data": {}}
        else:
            reply = "Please choose: 1️⃣ Timecard update or 2️⃣ Site update."

    elif "am to" in msg or "pm to" in msg:
        # fallback quick time entry
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        save_to_excel("Timecards.xlsx", ["DateTime", "User", "Work Hours"], [now, user, msg])
        reply = f"✅ Timecard saved! {msg} logged at {now}"

    elif "bye" in msg or "goodbye" in msg:
        reply = "It was great assisting you, Mr. Helal! Have a nice day 👋"

    else:
        reply = (
            f"🤖 You said: {msg}\n"
            "Try 'know' to learn about systems or 'update' to give new info."
        )

    return jsonify({'reply': reply})

# ---------- RUN APP ----------
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
