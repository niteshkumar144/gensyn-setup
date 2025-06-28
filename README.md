# 🚀 GENSYN AI RL-SWARM Setup — By NITESH KUMAWAT

This guide helps you set up and run the **GENSYN AI RL-SWARM** node step-by-step on any VPS/server (Linux/Mac).

---

## ⚡ **Full Setup & Run Guide**

---

## 🖥️ **System Requirements** ⚙️

- OS: Ubuntu 20.04 or newer (VPS recommended)
- CPU: 8 cores minimum
- RAM: 32 GB minimum
- Disk: 100GB SSD recommended
- Network: Stable internet connection

---

## ✅ 1️⃣ **Create & Run the Setup Script**

```bash
# Install Basic tools 
sudo apt update
sudo apt install nano -y

# Remove old script if exists
rm gensyn.sh

# Create new script
nano gensyn.sh

# # Make it executable
chmod +x gensyn.sh

# Run it
./gensyn.sh
```

## ➡️ **Now paste the below script inside nano:**

```bash
#!/bin/bash

# ===========================================================
# 🚀 GENSYN SETUP SCRIPT BY NITESH 🚀
# ===========================================================

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

# ---------------------------
# 🧹 Clean Up Old Repository
# ---------------------------
echo -e "${YELLOW}>> Removing any existing 'rl-swarm' directory...${NC}"
rm -rf rl-swarm

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
git switch main
git reset --hard
git clean -fd
git pull origin main

```
### ➡️  **Save & Exit nano:** `CTRL + X` → `Y` → `ENTER`

---

## 2️⃣ Create Tmux Session 
#### **Why Tmux?**
We use `tmux` to create a session because unlike `screen -S`, which can terminate unexpectedly, `tmux` provides better stability and flexibility. It ensures your processes keep running even if the connection to the terminal is lost.
```bash
tmux new -s gensyn
```

### ➡️ **Save & Exit:** `CTRL + X` → `Y` → `ENTER`

---
## ✅ 3️⃣ **Navigate to RL Swarm Folder and Set Up Virtual Environment**

After creating the Tmux session, navigate to the RL Swarm directory and set up the Python virtual environment:

```bash
# Change directory to the RL Swarm folder
cd rl-swarm

# Set up the Python virtual environment
python3 -m venv .venv
source .venv/bin/activate
```

⚠️ **NOTE: Before Run RL Swarm If You Have Old Swarm.pem File Then Import To rl-swarm Folder**

## ✅ 4️⃣  **Run the RL Swarm**

```bash
./run_rl_swarm.sh
```

#### ➡️ **Note:**  
After running, you may see:

![Screenshot 2025-06-14 233952](https://github.com/user-attachments/assets/5bf6963f-93b1-41e0-9c8c-6c999560799b)

- `Failed to open http://localhost:3000. Please open it manually.`
- `Waiting for modal userData.json to be created...`

Don’t worry — proceed to the next step.

---

## ✅ 5️⃣ **Start Cloudflare Tunnel (in a NEW tab)**

```bash
cloudflared tunnel --url http://localhost:3000
```
![Screenshot 2025-06-14 231532](https://github.com/user-attachments/assets/68749305-bfde-445f-a960-d3d2f0731fe0)

#### ➡️ Open the generated tunnel link in your browser, log in with Gmail & OTP, then return to the RL swarm terminal.

---

## ✅ 6️⃣ **Push Models to Hugging Face?**

After some time, you will be asked:

![Screenshot 2025-06-14 233825](https://github.com/user-attachments/assets/9fc7f899-b5ff-4570-bf76-9860e0d7c104)

Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N]

#### ➡️ Press `N` and Press Enter

---
## ✅ After successfully run it's look like this 👇
![Screenshot 2025-06-28 122541](https://github.com/user-attachments/assets/a8c2b9c8-b6ff-4941-ab05-ddcc4f0b1658)

## ✅ 7️⃣ **Backup Important Files** 📜

```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/backup.sh | bash
```

---

## ⚙️ **Important Commands** 👇

| Action | Command |
|--------|---------|
| Detach screen | `CTRL + B + D` |
| Re-attach screen | `tmux a -t gensyn` |
| Stop node | `CTRL + C` inside screen |

---

## 🎉 **All Done!**

You’re now part of the **GENSYN AI RL-SWARM**. Enjoy mining & contributing 🚀

---

✨ **THANK YOU❤️**  

⭐ **Star this repo if you found it helpful!**

𝕏 𝗙𝗼𝗹𝗹𝗼𝘄 𝗺𝗲╰┈➤ https://x.com/Nitesh_Kumar177

---
