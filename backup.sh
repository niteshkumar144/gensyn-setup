#!/bin/bash

clear

# ===============================
# INDIAN FLAG STYLE ASCII BANNER
# ===============================

# Define colors: Saffron, White, Green
SAFFRON='\033[38;5;208m'  # Orange-ish
WHITE='\033[1;37m'         # Bright White
GREEN='\033[1;32m'         # Green
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================="
echo -e "${SAFFRON}███    ██ ██ ████████ ███████ ███████ ██   ██ "
echo -e "${SAFFRON}████   ██ ██    ██    ██      ██      ██   ██ "
echo -e "${WHITE}██ ██  ██ ██    ██    █████   ███████ ███████ "
echo -e "${GREEN}██  ██ ██ ██    ██    ██           ██ ██   ██ "
echo -e "${GREEN}██   ████ ██    ██    ███████ ███████ ██   ██ "
echo -e "${CYAN}====================================================="
echo -e "${CYAN}      🚀 Automated GENSYN Setup by NITESH 🚀"
echo -e "${CYAN}=====================================================${NC}"

# ================================
# 🚀 RL-SWARM Backup & Tunnel Script — By Nitesh
# ================================

# ----------- COLORS -------------
INFO='\033[1;36m'      # Light Cyan
SUCCESS='\033[1;32m'   # Light Green
WARNING='\033[1;33m'   # Yellow
ERROR='\033[1;31m'     # Light Red
HIGHLIGHT='\033[1;35m' # Light Magenta
BOLD='\033[1m'
NC='\033[0m'

# ----------- FUNCTIONS ----------
log() {
  echo -e "${INFO}[INFO]${NC} $1"
}

success() {
  echo -e "${SUCCESS}[OK]${NC} $1"
}

warn() {
  echo -e "${WARNING}[WARN]${NC} $1"
}

error() {
  echo -e "${ERROR}[ERROR]${NC} $1"
}

line() {
  echo -e "${HIGHLIGHT}--------------------------------------------------${NC}"
}

# --------- DEPENDENCIES ---------
line
log "Checking dependencies: nc & lsof"
if ! command -v nc >/dev/null || ! command -v lsof >/dev/null; then
  log "Installing missing tools..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y netcat lsof
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew >/dev/null; then
      brew install netcat lsof
    else
      error "Homebrew not found. Please install manually."
      exit 1
    fi
  else
    error "Unsupported OS. Install nc and lsof manually."
    exit 1
  fi
fi
success "Dependencies are installed."

# --------- CHECK DIRECTORY ---------
line
log "Checking rl-swarm directory..."
if [[ $(basename "$PWD") == "rl-swarm" ]]; then
  RL_SWARM_DIR="$PWD"
elif [[ -d "$HOME/rl-swarm" ]]; then
  RL_SWARM_DIR="$HOME/rl-swarm"
else
  error "rl-swarm directory not found!"
  exit 1
fi
success "Found rl-swarm at: $RL_SWARM_DIR"
cd "$RL_SWARM_DIR"

# ---------- INSTALL CLOUDFLARED ----------
line
log "Checking cloudflared..."
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) CARCH="amd64" ;;
  aarch64|arm64) CARCH="arm64" ;;
  *) error "Unsupported architecture: $ARCH"; exit 1 ;;
esac

if ! command -v cloudflared >/dev/null; then
  log "Installing cloudflared..."
  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -LO "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CARCH}.deb"
    sudo dpkg -i cloudflared-linux-${CARCH}.deb || sudo apt --fix-broken install -y
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew >/dev/null; then
      brew install cloudflared
    else
      curl -LO "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-${CARCH}.tgz"
      tar -xzf cloudflared-darwin-${CARCH}.tgz
      chmod +x cloudflared && sudo mv cloudflared /usr/local/bin/
    fi
  fi
  cd "$RL_SWARM_DIR"
fi
success "cloudflared is ready."

# --------- PYTHON3 CHECK ---------
line
log "Checking python3..."
if ! command -v python3 >/dev/null; then
  log "Installing python3..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y python3 python3-pip
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew >/dev/null; then
      brew install python
    else
      error "Homebrew not found. Install python3 manually."
      exit 1
    fi
  fi
fi
success "python3 is installed."

# --------- START SERVER ----------
line
log "Starting local HTTP server..."
PORT=8000
TRIES=0
while nc -z localhost "$PORT" 2>/dev/null; do
  ((PORT++))
  ((TRIES++))
  [[ $TRIES -gt 10 ]] && error "No free ports found!" && exit 1
done

python3 -m http.server "$PORT" > /tmp/http_server.log 2>&1 &
HTTP_PID=$!
sleep 3
ps -p $HTTP_PID >/dev/null || { error "Failed to start HTTP server."; exit 1; }
success "HTTP server running on port $PORT."

# --------- START TUNNEL ----------
line
log "Starting Cloudflare tunnel..."
cloudflared tunnel --url "http://localhost:$PORT" > /tmp/cloudflared.log 2>&1 &
CF_PID=$!

sleep 8
URL=$(grep -o 'https://[^ ]*\.trycloudflare\.com' /tmp/cloudflared.log | head -n1)
[[ -z "$URL" ]] && sleep 5 && URL=$(grep -o 'https://[^ ]*\.trycloudflare\.com' /tmp/cloudflared.log | head -n1)
[[ -z "$URL" ]] && error "Tunnel failed!" && kill $HTTP_PID $CF_PID && exit 1

success "Tunnel is live at: ${HIGHLIGHT}$URL${NC}"

# -------- FINAL OUTPUT ----------
line
echo -e "${SUCCESS}${BOLD}✅ Backup these files and keep them safe!${NC}"
line
echo -e "${BOLD}• swarm.pem${NC} => ${HIGHLIGHT}${URL}/swarm.pem${NC}"
echo -e "${BOLD}• userData.json${NC} => ${HIGHLIGHT}${URL}/modal-login/temp-data/userData.json${NC}"
echo -e "${BOLD}• userApiKey.json${NC} => ${HIGHLIGHT}${URL}/modal-login/temp-data/userApiKey.json${NC}"
line
echo -e "${INFO}To download on another server:${NC}"
echo -e "${WARNING}wget -O swarm.pem ${URL}/swarm.pem${NC}"
echo -e "${WARNING}wget -O userData.json ${URL}/modal-login/temp-data/userData.json${NC}"
echo -e "${WARNING}wget -O userApiKey.json ${URL}/modal-login/temp-data/userApiKey.json${NC}"
line
echo -e "${SUCCESS}Press ${WARNING}Ctrl+C${SUCCESS} to stop the server when you’re done.${NC}"

trap 'echo -e "${WARNING}Shutting down...${NC}"; kill $HTTP_PID $CF_PID; echo -e "${SUCCESS}Stopped.${NC}"' INT
wait
