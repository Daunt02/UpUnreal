# ⚡ SigilOS Initialization Script for Windows PowerShell
# Ensure: Git, Docker Desktop, Node.js 18+, Python 3.10+, and Quasar CLI are installed

Write-Host "🚀 Starting SigilOS Full Local Bootstrap..."

# Clone repo
Write-Host "📦 Cloning GitHub repo..."
git clone https://github.com/Daunt02/sigilos-app.git
cd sigilos-app

# Start Docker Desktop if not already running
$dockerProcess = Get-Process -Name "Docker Desktop" -ErrorAction SilentlyContinue
if (-not $dockerProcess) {
    Write-Host "🐳 Starting Docker Desktop..."
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Start-Sleep -Seconds 20
}

# FRONTEND SETUP
Write-Host "🌐 Setting up Quasar Frontend..."
cd client
if (-not (Test-Path node_modules)) {
    npm install
}
cd ..

# BACKEND SETUP
Write-Host "🧠 Setting up Python FastAPI Backend..."
cd server
if (-not (Test-Path venv)) {
    python -m venv venv
}
.\venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt
deactivate
cd ..

# DOCKER CHECK
Write-Host "🐳 Validating Docker Compose file..."
if (-not (Test-Path "docker-compose.yml")) {
    Write-Host "❌ docker-compose.yml not found. Exiting..." -ForegroundColor Red
    exit
}

# LAUNCH FULL STACK
Write-Host "🔥 Building and launching containers..."
docker-compose down
docker-compose up --build

Write-Host "✅ SigilOS App is now live on:"
Write-Host "🌐 Frontend: http://localhost:9000"
Write-Host "🔗 Backend API: http://localhost:8000/api/sigils"
