# 🚀 GENSYN Automated Setup — By NITESH 🇮🇳

This repository contains a fully automated script to setup GENSYN AI RL-SWARM node on your VPS or server.  
Follow these clear steps 👇

---

## ✅ **How to Use**

### 🔹 **Step 1 — Run Script**
```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
This will:

Remove old rl-swarm repo (if any)

Install Python, NodeJS, Yarn, Cloudflared, CUDA

Clone GENSYN repo

Install all dependencies

🔹 Step 2 — Create Screen Session
bash
Copy
Edit
screen -S gensyn
🔹 Step 3 — Enter Repo
bash
Copy
Edit
cd rl-swarm
🔹 Step 4 — Edit Config
bash
Copy
Edit
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
Change:

float: 32 ⟶ 16

true ⟶ false

batch size: 2 ⟶ 1

🔹 Step 5 — Run RL Swarm
bash
Copy
Edit
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
🔹 Step 6 — Start Cloudflared Tunnel
Open new terminal tab and run:

bash
Copy
Edit
cloudflared tunnel --url http://localhost:3000
👉 Login as per prompt

⚡ One-Liner Install
bash
Copy
Edit
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
🙌 Thank You!
Created with ❤️ by NITESH

yaml
Copy
Edit

---

### 📌 **Step 4 — Commit**

✅ **Commit message:**  
Add professional README.md guide

yaml
Copy
Edit

✅ **Click:** `Commit new file`

---

## 🎉 **Done!**

Ab tera guide direct **repo pe live ho jayega!**  
Jo bhi tera repo dekhega — woh **poora step-by-step guide** README mein milega.

---

Agar chahe toh mujhe Collaborator bana de — toh main bhi kabhi future mein tera guide update kar dunga! 🔥✨







