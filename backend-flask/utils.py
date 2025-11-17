import jwt
from passlib.context import CryptContext
from datetime import datetime, timedelta

SECRET = "ftz-secret-key"
ALGO = "HS256"

pwd = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_pass(password):
    return pwd.hash(password)

def verify_pass(plain, hashed):
    return pwd.verify(plain, hashed)

def create_token(data: dict):
    to_encode = data.copy()
    to_encode["exp"] = datetime.utcnow() + timedelta(days=1)
    return jwt.encode(to_encode, SECRET, algorithm=ALGO)

def decode_token(token):
    return jwt.decode(token, SECRET, algorithms=[ALGO])
