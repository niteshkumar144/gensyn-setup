# 🇮🇳✨ GENSYN Setup Guide by NITESH ✨🇮🇳

## 📌 **Step-by-Step VPS Guide (Mac/Linux)**

---

## 🖥️ **Device/System Requirements**

✅ Linux VPS or Mac Terminal  
✅ Internet Connection  
✅ GitHub account (for script)

---

## ⚡ **Commands to Setup**

### 🚀 **1️⃣ Run the Setup Script**
```bash
curl -s https://raw.githubusercontent.com/niteshkumar144/gensyn-setup/main/setup.sh | bash


🖥️ 2️⃣ Create a Screen Session
screen -S gensyn


📂 3️⃣ Navigate to Project Folder
cd rl-swarm


📝 4️⃣ Edit Config File
nano hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
📌 In the config file, do this:

float: 32 → change to 16

true → change to false

batch size: 2 → change to 1

Then save & exit:

For nano: CTRL + O (save), ENTER (confirm), CTRL + X (exit)


🔁 5️⃣ Run RL Swarm
RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh


🌐 6️⃣ Create Tunnel in New Terminal
In a new tab or window, run:
cloudflared tunnel --url http://localhost:3000
Login with your Cloudflare account when prompted.

✅ Everything is Done!

📌 Pro Tip:

To exit screen safely: CTRL + A + D

To reattach later:

screen -r gensyn


🏆 Credits
Script & Guide by: NITESH
🇮🇳✨ Happy Building!

