# 🚀 GENSYN Automated Setup — By NITESH 🇮🇳

This repository provides a **one-liner automated script** to set up a **GENSYN AI RL-SWARM** node on any VPS/server (Linux/Mac).

---

## ⚡ Commands to Setup

---

## 1️⃣ Run the Setup Script

```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
```

---

## 2️⃣ Create a Screen Session

```bash
screen -S gensyn
```

---

## 3️⃣ Navigate to Project Folder

```bash
cd rl-swarm
```

---

## 4️⃣ Edit Config File

```bash
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
```

### 📌 In the config file, change:

```
float: 32  -->  16
true       -->  false
batch size: 2  -->  1
```

✅ **To save & exit:**

- `CTRL + X`
- `Y`
- `ENTER`

---

## 5️⃣ Run RL Swarm

```bash
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
```

---

## 6️⃣ Start Cloudflare Tunnel (in a NEW tab)

```bash
cloudflared tunnel --url http://localhost:3000
```

---

## ✅ Done! Open the tunnel link and log in to access your Node.

---

## ⭐ Made with ❤️ by **NITESH**

**Star this repo if you find it useful!**

