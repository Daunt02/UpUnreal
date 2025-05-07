# 📁 Create Root Project Directory
mkdir unreal-vue-map-app
cd unreal-vue-map-app

# 📦 Create Quasar Vue Frontend
quasar create client --kit quasar --branch stable --no-prompt
cd client
npm install mapbox-gl axios
cd ..

# 🧠 Python Backend Structure
mkdir server
cd server
python -m venv venv
.\venv\Scripts\Activate
pip install fastapi uvicorn python-dotenv

mkdir app
cd app

# 📜 FastAPI main.py
@'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import json, os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get("/api/sigils")
async def get_sigils():
    with open("sigil_data.json", "r", encoding="utf-8") as f:
        return json.load(f)
'@ | Set-Content -Encoding UTF8 .\main.py

# 🌐 Example Crawl4AI sigil_data.json
@'
[
  {
    "title": "DJ Ritual Node",
    "coordinates": [-74.006, 40.7128],
    "icon": "music",
    "tier": 3,
    "trust": 0.91
  },
  {
    "title": "Visual Sigil Drop",
    "coordinates": [-118.2437, 34.0522],
    "icon": "star",
    "tier": 2,
    "trust": 0.75
  }
]
'@ | Set-Content -Encoding UTF8 .\sigil_data.json

cd ../..

# 🎮 Unreal Plugin Folder + Sync Script
mkdir unreal
mkdir .\unreal\Plugins
mkdir .\unreal\Plugins\WebApiFetcher

@'
import requests
import unreal

def fetch_sigil_data():
    try:
        response = requests.get("http://localhost:8000/api/sigils")
        sigils = response.json()
        for sigil in sigils:
            print(f"Spawning: {sigil['title']} at {sigil['coordinates']}")
            # Replace with actor spawn logic
    except Exception as e:
        print(f"Error fetching sigils: {e}")
'@ | Set-Content -Encoding UTF8 .\unreal\Plugins\WebApiFetcher\fetch_sigil.py

# 📝 Generate README
@'
# Unreal x Vue x Crawl4AI Sync

## Run Frontend
cd client
quasar dev

## Run Backend
cd server
.\venv\Scripts\Activate
uvicorn app.main:app --reload

## Unreal Plugin
Python script located in \unreal\Plugins\WebApiFetcher\fetch_sigil.py
'@ | Set-Content -Encoding UTF8 .\README.md

Write-Host "`n✅ Unreal-Vue-Crawl4AI system scaffolded. Open 
VS Code or run frontend/backend now!"

Start-Process powershell -ArgumentList 'cd ./client; quasar dev'
Start-Sleep -Seconds 2
Start-Process powershell -ArgumentList 'cd ./server; .\venv\Scripts\Activate; uvicorn app.main:app --reload'
Write-Host "\n🌐 http://localhost:9000  (Vue frontend)"
Write-Host "🧠 http://localhost:8000/api/sigils (Backend JSON)"
Write-Host "🎮 Open Unreal → HoustonMap.umap manually to sync"