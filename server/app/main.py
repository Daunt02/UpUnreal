from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import json
import os

app = FastAPI()

# Allow frontend cross-origin requests (Vue/Netlify/Unreal)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get("/api/sigils")
async def get_sigils():
    path = os.path.join(os.path.dirname(__file__), "sigil_data.json")
    with open(path, "r") as f:
        return json.load(f)
