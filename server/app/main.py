from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pathlib import Path
import json
import logging

app = FastAPI()

# Setup basic logging
logging.basicConfig(level=logging.INFO)

# Allow frontend dev (Quasar) and production (Netlify)
origins = [
    "http://localhost:9000",
    "https://your-netlify-site.netlify.app"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Path to sigils.json
DATA_FILE = Path(__file__).parent / "data" / "sigils.json"

@app.get("/api/health")
def health_check():
    logging.info("Health check requested")
    return {"status": "OK"}

@app.get("/api/sigils")
def get_sigils():
    if not DATA_FILE.exists():
        logging.error(f"File not found: {DATA_FILE}")
        raise HTTPException(status_code=404, detail="sigils.json not found")
    try:
        with open(DATA_FILE, encoding="utf-8-sig") as f:
            data = json.load(f)
            logging.info(f"Loaded {len(data)} sigils")
            return data
    except json.JSONDecodeError as e:
        logging.error(f"JSON decode error: {e}")
        raise HTTPException(status_code=500, detail=f"JSON decode error: {e}")
