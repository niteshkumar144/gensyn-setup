#!/bin/bash

clear

# ===============================
# ASCII Art Banner
# ===============================
echo "====================================================="
echo "███    ██ ██ ████████ ███████ ███████ ██   ██ "
echo "████   ██ ██    ██    ██      ██      ██   ██ "
echo "██ ██  ██ ██    ██    █████   ███████ ███████ "
echo "██  ██ ██ ██    ██    ██           ██ ██   ██ "
echo "██   ████ ██    ██    ███████ ███████ ██   ██ "
echo "====================================================="
echo "      🚀 Automated GENSYN Setup by NITESH 🚀"
echo "====================================================="

# ===============================
# STEP 1 — Cleanup old rl-swarm
# ===============================
echo ""
echo ">> Removing any old rl-swarm directory..."
rm -rf rl-swarm

# ===============================
# STEP 2 — Install Required Packages
# ===============================
echo ""
echo ">> Updating system and installing essentials..."
sudo apt update && sudo apt install -y sudo

sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential gcc g++

# CUDA
echo ""
echo ">> Installing CUDA..."
[ -f cuda.sh ] && rm cuda.sh
curl -o cuda.sh https://raw.githubusercontent.com/zunxbt/gensyn-testnet/main/cuda.sh
chmod +x cuda.sh
. ./cuda.sh

# Node.js & Yarn
echo ""
echo ">> Installing Node.js and Yarn..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Check Versions
echo ""
echo ">> Checking versions..."
node -v
npm -v
yarn -v
python3 --version

# ===============================
# STEP 3 — Clone GENSYN Repo
# ===============================
echo ""
echo ">> Cloning GENSYN repository..."
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm

# ===============================
# STEP 4 — Setup Python Virtual Env
# ===============================
echo ""
echo ">> Setting up Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

# ===============================
# STEP 5 — Setup modal-login
# ===============================
echo ""
echo ">> Installing modal-login dependencies..."
cd modal-login
yarn install
yarn upgrade
yarn add next@latest
yarn add viem@latest
cd ..

# ===============================
# STEP 6 — Git Reset & Checkout Version
# ===============================
echo ""
echo ">> Resetting git state..."
git reset --hard
git pull origin main
git checkout tags/v0.4.3

# ===============================
# STEP 7 — Install Cloudflared
# ===============================
echo ""
echo ">> Installing Cloudflared (.deb)..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
cloudflared --version
echo ">> Cloudflared installed successfully."

# ===============================
# STEP 8 — ALL DONE + Manual Steps
# ===============================
echo ""
echo "====================================================="
echo " 🎉 ALL DONE! ~ Script by NITESH"
echo "====================================================="
echo ""
echo "👉 Next steps to run manually:"
echo ""
echo "1️⃣  Start a new screen session:"
echo "    screen -S gensyn"
echo ""
echo "2️⃣  Inside the screen, go to the project directory:"
echo "    cd rl-swarm"
echo ""
echo "3️⃣  Open your config file for editing:"
echo "    nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml"
echo ""
echo "✅ Thank you!"
echo ""
