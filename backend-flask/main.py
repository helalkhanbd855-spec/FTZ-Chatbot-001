from fastapi import FastAPI, Depends, HTTPException, Header
from sqlalchemy.orm import Session
from .database import Base, engine, get_db
from . import models, schemas, utils, chat
import openpyxl

Base.metadata.create_all(bind=engine)

app = FastAPI()

# --------------------------------------
# REGISTER
# --------------------------------------
@app.post("/register")
def register(user: schemas.UserCreate, db: Session = Depends(get_db)):
    hashed = utils.hash_pass(user.password)
    new_user = models.User(name=user.name, email=user.email, password=hashed)
    db.add(new_user)
    db.commit()
    return {"msg": "Registration successful!"}

# --------------------------------------
# LOGIN
# --------------------------------------
@app.post("/login")
def login(user: schemas.UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if not db_user:
        raise HTTPException(400, "User not found")

    if not utils.verify_pass(user.password, db_user.password):
        raise HTTPException(400, "Wrong password")

    token = utils.create_token({"user_id": db_user.id})
    return {"token": token}

# --------------------------------------
# CHATBOT
# --------------------------------------
@app.post("/chat")
def chat_api(request: schemas.ChatRequest, token: str = Header(), db: Session = Depends(get_db)):

    user_data = utils.decode_token(token)
    user_id = user_data["user_id"]

    reply = chat.get_bot_reply(request.message)

    save = models.ChatHistory(user_id=user_id, message=request.message, reply=reply)
    db.add(save)
    db.commit()

    return {"reply": reply}

# --------------------------------------
# EXPORT CHAT TO EXCEL
# --------------------------------------
@app.get("/export")
def export(token: str = Header(), db: Session = Depends(get_db)):

    user_data = utils.decode_token(token)
    user_id = user_data["user_id"]

    chats = db.query(models.ChatHistory).filter(models.ChatHistory.user_id == user_id).all()

    wb = openpyxl.Workbook()
    ws = wb.active
    ws.append(["Message", "Reply"])

    for c in chats:
        ws.append([c.message, c.reply])

    file = "chat_history.xlsx"
    wb.save(file)
    return {"message": "Export Done", "file": file}
