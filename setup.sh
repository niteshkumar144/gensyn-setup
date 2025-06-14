#!/bin/bash

# ===========================================================
# 🚀 GENSYN SETUP SCRIPT BY NITESH 🚀
# ===========================================================

# ---------------------------
# 🎨 Colors
# ---------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ---------------------------
# 🎉 ASCII BANNER
# ---------------------------
echo -e "${RED}███    ██ ██ ████████ ███████ ███████ ██   ██"
echo -e "${GREEN}████   ██ ██    ██    ██      ██      ██   ██"
echo -e "${YELLOW}██ ██  ██ ██    ██    █████   ███████ ███████"
echo -e "${BLUE}██  ██ ██ ██    ██    ██           ██ ██   ██"
echo -e "${CYAN}██   ████ ██    ██    ███████ ███████ ██   ██${NC}"

echo -e "${CYAN}====================================================="
echo -e " 📌 Setup Script - Automated by NITESH"
echo -e "=====================================================${NC}"

# ---------------------------
# 🧹 Clean Up Old Repository
# ---------------------------
echo -e "${YELLOW}>> Removing any existing 'rl-swarm' directory...${NC}"
rm -rf rl-swarm

# ---------------------------
# ⚙️  Install Required Packages
# ---------------------------
echo -e "${BLUE}>> Updating & Installing core packages...${NC}"
sudo apt update && sudo apt install -y sudo
sudo apt update && sudo apt install -y \
  python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential gcc g++

echo -e "${BLUE}>> Running CUDA script...${NC}"
[ -f cuda.sh ] && rm cuda.sh
curl -o cuda.sh https://raw.githubusercontent.com/zunxbt/gensyn-testnet/main/cuda.sh
chmod +x cuda.sh && . ./cuda.sh

echo -e "${BLUE}>> Installing Node.js & Yarn...${NC}"
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# ---------------------------
# 🔍 Check Versions
# ---------------------------
echo -e "${GREEN}>> Checking installed versions:${NC}"
node -v
npm -v
yarn -v
python3 --version

# ---------------------------
# 🧩 Clone and Prepare Repository
# ---------------------------
echo -e "${BLUE}>> Cloning GENSYN repo...${NC}"
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm

echo -e "${BLUE}>> Setting up Python virtual environment...${NC}"
python3 -m venv .venv
source .venv/bin/activate

echo -e "${BLUE}>> Installing frontend dependencies...${NC}"
cd modal-login
yarn install
yarn upgrade
yarn add next@latest
yarn add viem@latest
cd ..

echo -e "${BLUE}>> Resetting Git repo and pulling latest changes...${NC}"
git reset --hard
git pull origin main
git checkout tags/v0.4.3

# ---------------------------
# ☁️  Install Cloudflared (DEB method)
# ---------------------------
echo -e "${YELLOW}>> Installing Cloudflared (.deb)...${NC}"
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

if [ -f cloudflared-linux-amd64.deb ]; then
  sudo dpkg -i cloudflared-linux-amd64.deb || sudo apt-get install -f -y
  cloudflared --version
  echo -e "${GREEN}>> Cloudflared installed successfully.${NC}"
else
  echo -e "${RED}>> Failed to download Cloudflared .deb!${NC}"
fi

# ---------------------------
# 🗂️  Manage Screen Session
# ---------------------------
echo -e "${YELLOW}>> Checking for existing 'gensyn' screen session...${NC}"
if screen -list | grep -q "gensyn"; then
  screen -S gensyn -X quit
  echo -e "${GREEN}>> Old 'gensyn' screen terminated.${NC}"
fi

echo -e "${GREEN}>> Starting new 'gensyn' screen session...${NC}"
screen -S gensyn

# ---------------------------
# 📂 Change to rl-swarm Directory
# ---------------------------
cd rl-swarm

# ---------------------------
# ✏️  Open Config File in Nano
# ---------------------------
echo -e "${BLUE}>> Opening your config file with nano...${NC}"
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml

# ---------------------------
# ✅ Done!
# ---------------------------
echo -e "${CYAN}====================================================="
echo -e " 🎉 ALL DONE! ~ Script by NITESH"
echo -e "=====================================================${NC}"
