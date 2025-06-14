# 🚀 GENSYN AI RL-SWARM Setup — By NITESH KUMAWAT 🇮🇳

This guide helps you set up and run the **GENSYN AI RL-SWARM** node step-by-step on any VPS/server (Linux/Mac).

---

## ⚡ **Full Setup & Run Guide**

### ✅ 1️⃣ **Create & Run the Setup Script**

```bash
# Remove old script if exists
rm gensyn.sh

# Create new script
nano gensyn.sh
```

➡️ **Now paste the below script inside nano:**

```bash
#!/bin/bash

# Colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
echo " _   _ _ _ _______ _______ _____ _    _ "
echo "| \ | | | |__   __|__   __|_   _| |  | |"
echo "|  \| | | |  | |     | |    | | | |__| |"
echo "| . ` | | |  | |     | |    | | |  __  |"
echo "| |\  | | |  | |     | |   _| |_| |  | |"
echo "|_| \_|_|_|  |_|     |_|  |_____|_|  |_|"
echo "         By NITESH 🇮🇳"
echo -e "${NC}"

# Update & Install Dependencies
sudo apt update && sudo apt install -y sudo
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2 build-essential gcc g++

# CUDA
[ -f cuda.sh ] && rm cuda.sh
curl -o cuda.sh https://raw.githubusercontent.com/zunxbt/gensyn-testnet/main/cuda.sh && chmod +x cuda.sh && . ./cuda.sh

# NodeJS & Yarn
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Version Check
node -v
npm -v
yarn -v
python3 --version

# Clone Repo
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm

# Python Venv
python3 -m venv .venv
source .venv/bin/activate

# Modal Login Setup
cd modal-login
yarn install
yarn upgrade
yarn add next@latest
yarn add viem@latest
cd ..

# Update Repo
git reset --hard
git pull origin main
git checkout tags/v0.4.3
```

➡️ **Save & Exit nano:** `CTRL + X` → `Y` → `ENTER`

```bash
# Make it executable
chmod +x gensyn.sh

# Run it
./gensyn.sh
```

---

### ✅ 2️⃣ **Create a Screen Session**

```bash
screen -S gensyn
```

---

### ✅ 3️⃣ **Go to the Project Folder**

```bash
cd rl-swarm
```

---

### ✅ 4️⃣ **Edit Config File**

```bash
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
```

**Changes to make:**

| Original | New |
|----------|-----|
| `float: 16` | `float: 32` |
| `true` | `false` |
| `batch size: 2` | `batch size: 1` |

➡️ **Save & Exit:** `CTRL + X` → `Y` → `ENTER`

---

### ✅ 5️⃣ **Run the RL Swarm**

```bash
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
```

**You will be asked:**

- `Would you like to connect to the Testnet? [Y/n]` → **Y**
- `Which swarm would you like to join (Math (A) or Math Hard (B))? [A/b]` → **A**
- `How many parameters (in billions)? [0.5, 1.5, 7, 32, 72]` → **7**

➡️ **Note:**  
After running, you may see:
- `Failed to open http://localhost:3000. Please open it manually.`
- `Waiting for modal userData.json to be created...`

Don’t worry — proceed to the next step.

---

### ✅ 6️⃣ **Start Cloudflare Tunnel (in a NEW tab)**

```bash
cloudflared tunnel --url http://localhost:3000
```

➡️ Open the generated tunnel link in your browser, log in with Gmail & OTP, then return to the RL swarm terminal.

---

### ✅ 7️⃣ **Push Models to Hugging Face?**

After some time, you will be asked:

```
Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N]
```

➡️ **Select:** `N`

---

### ✅ 8️⃣ **WandB Prompt**

When you see:

```
wandb: (1) Create a W&B account
wandb: (2) Use an existing W&B account
wandb: (3) Don't visualize my results
wandb: Enter your choice:
```

➡️ **Select:** `3`

---

### ✅ 9️⃣ **Backup Important Files**

```bash
[ -f backup.sh ] && rm backup.sh
curl -sSL -O https://raw.githubusercontent.com/AbhiEBA/gensyn1/main/backup.sh
chmod +x backup.sh
./backup.sh
```

---

## ⚙️ **Important Commands**

| Action | Command |
|--------|---------|
| Detach screen | `CTRL + A + D` |
| Re-attach screen | `screen -r gensyn` |
| Stop node | `CTRL + C` inside screen |
| Quit screen | `screen -S gensyn -X quit` |

---

## 🎉 **All Done!**

You’re now part of the **GENSYN AI RL-SWARM**. Enjoy mining & contributing 🚀

---

✨ **Made with ❤️ by [NITESH KUMAWAT 🇮🇳]**  
⭐ **Star this repo if you found it helpful!**
