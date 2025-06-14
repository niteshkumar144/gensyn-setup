# 🚀 GENSYN Setup — By NITESH KUMAWAT

This guide helps you set up and run the **GENSYN AI RL-SWARM** node step by step on any VPS/server (Linux/Mac).

---

## ⚡ **Steps to Setup and Run**

### 1️⃣ Run the Setup Script

```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
```

---

### 2️⃣ Create a Screen Session

```bash
screen -S gensyn
```

---

### 3️⃣ Navigate to Project Folder

```bash
cd rl-swarm
```

---

### 4️⃣ Edit Config File

```bash
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
```

**Changes to make:**

- `float: 32` → `16`
- `true` → `false`
- `batch size: 2` → `1`

➡️ **Save & Exit:** `CTRL + X` → `Y` → `ENTER`

---

### 5️⃣ Run RL Swarm

```bash
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
```

👇**During this step, you will be asked:**

➡️ Would you like to connect to the Testnet? [Y/n] Y

➡️ Which swarm would you like to join (Math (A) or Math Hard (B))? [A/b] A

➡️ How many parameters (in billions)? [0.5, 1.5, 7, 32, 72] 7

✅ **Select option Y, A and 7**

➡️ **Note:** After running, you will see:

➡️ Failed to open http://localhost:3000. Please open it manually.
➡️ Waiting for modal userData.json to be created...

---

### 6️⃣ Next Start Cloudflare Tunnel (in a NEW tab)

```bash
cloudflared tunnel --url http://localhost:3000
```

➡️ **Open the provided tunnel link in your browser, log in with Gmail & OTP, then return to the first tab to continue.**

---

### 7️⃣ After some time, you will be asked:

➡️ Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N] N

✅ **Select option N**

---

### 8️⃣ After a while, when few training completed, you will see:

```
wandb: (1) Create a W&B account
wandb: (2) Use an existing W&B account
wandb: (3) Don't visualize my results
wandb: Enter your choice: 3
```

✅ **Select option 3.**

---

### 9️⃣ Backup Important Files

```bash
[ -f backup.sh ] && rm backup.sh; curl -sSL -O https://raw.githubusercontent.com/AbhiEBA/gensyn1/main/backup.sh && chmod +x backup.sh && ./backup.sh
```

### 👇 Important Commands

- **Detach Screen:** `CTRL + A + D`
- **Attach Screen:** `screen -r gensyn`

---

## 🎉 **You’re all set!**

---

**THANK YOU** ❤️

---

✨ Made with ❤️ by **NITESH** — Star ⭐ this repo if it helped you!

