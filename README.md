# 🚀 GENSYN Automated Setup — By NITESH 🇮🇳

This repository provides a **one-liner automated script** to set up **GENSYN AI RL-SWARM** node on any VPS/server (Linux/Mac).

---

# ⚡ Quick Commands to Setup

---

# 1️⃣ Run the Setup Script

```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
2️⃣ Create a Screen Session
bash
Copy
Edit
screen -S gensyn
3️⃣ Navigate to Project Folder
bash
Copy
Edit
cd rl-swarm
4️⃣ Edit Config File
bash
Copy
Edit
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
📌 Inside the config file, change:

float: 32 ➜ 16

true ➜ false

batch size: 2 ➜ 1

💾 Save & Exit:

Press CTRL+S → CTRL+X

5️⃣ Run RL Swarm
bash
Copy
Edit
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
6️⃣ Open Cloudflared Tunnel (New Tab)
bash
Copy
Edit
cloudflared tunnel --url http://localhost:3000
✅ Login when prompted

🎉 All Done — Enjoy Your Node!
🔑 One-Liner Anytime
bash
Copy
Edit
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash
Made with ❤️ by NITESH
