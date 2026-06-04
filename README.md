# PyTorch / ComfyUI / Code-Server Container Workspace

This repository contains configuration files, scripts, and dependencies to build and run a GPU-enabled Docker workspace containing **PyTorch**, **ComfyUI**, and **code-server** (VS Code in the browser).

---

## 🔑 Key Configuration: The Decryption Password

Many operations (such as Docker Hub login or decrypting Hugging Face and Civitai tokens at runtime) require setting the `pass` environment variable:

* **Windows (PowerShell)**:
  ```powershell
  $env:pass="your_decryption_password"
  ```
* **Linux / macOS (Bash/Zsh)**:
  ```bash
  export pass="your_decryption_password"
  ```

---

## 🛠️ Workflows

### Method 1: Local Build & Deploy (Recommended)
This is the standard workflow where you build the container locally, push it to Docker Hub, and pull it on the remote server.

#### 1. Build and Push (Locally)
Make sure you have Docker running locally and the `pass` environment variable set.
```bash
# Log in to Docker Hub using Makefile (auto-decrypts token)
make login

# Build the image and push it to Docker Hub
make push
```

#### 2. Run on the Remote Machine
Ensure Docker and the **NVIDIA Container Toolkit** are installed on the remote machine. Copy [docker-compose.yml](docker-compose.yml) and [run.sh](run.sh) to the remote, set the `pass` environment variable, and run:
```bash
export pass="your_decryption_password"
./run.sh run
```

---

### Method 2: Build Directly on the Remote Machine
Use this approach if you want to build the Docker image directly on the remote server.

#### 1. Transfer the Repository to the Remote
Clone this repository on your remote machine:
```bash
git clone https://github.com/mhnakif/repo.git
cd repo
```

#### 2. Build the Image
```bash
docker build -t mhnakif/repo:latest .
```
*(Optionally, use `--no-cache` to force a clean build from scratch: `docker build --no-cache -t mhnakif/repo:latest .`)*

#### 3. Run the Container
Set the decryption password and start the workspace:
```bash
export pass="your_decryption_password"
./run.sh run
```
*(Or use `./launch.sh` to run using standard Docker CLI instead of Compose).*

---

## 📂 Container Utilities & CLI Command Shortcuts

Because `/workspace/scripts/` is added to the system `PATH` inside the container, you can pass different commands to `run.sh` to run specific helper scripts:

* **Start Everything**:
  ```bash
  ./run.sh run
  ```
  Decrypts credentials, downloads ComfyUI (if missing), starts the ComfyUI server, and launches `code-server` on port `8080`.
* **Sync ComfyUI state with Hugging Face**:
  - **Pull ComfyUI**: `./run.sh pull` (Downloads your ComfyUI workspace/models from Hugging Face).
  - **Push ComfyUI**: `./run.sh push` (Backs up ComfyUI workspace/models to Hugging Face).
* **Download Models / Loras**:
  ```bash
  # Targets: l|lora, u|unet, c|clip, v|vae
  ./run.sh d <target> <url> [url...]
  ```
* **Civitai Downloader**:
  ```bash
  ./run.sh civit <civitai-download-url> [output-filename]
  ```
