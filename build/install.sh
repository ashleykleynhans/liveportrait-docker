#!/usr/bin/env bash
set -e

# Create and use the Python venv
python3 -m venv --system-site-packages /venv

# Install Torch
source /venv/bin/activate
pip3 install --no-cache-dir torch==${TORCH_VERSION} torchvision torchaudio --index-url ${INDEX_URL}
pip3 install --no-cache-dir xformers==${XFORMERS_VERSION} --index-url ${INDEX_URL}

# Clone the git repo of LivePortrait and set version
cd /
git clone https://github.com/KwaiVGI/LivePortrait.git
cd /LivePortrait
git checkout ${LIVEPORTRAIT_COMMIT}

# Install the dependencies for LivePortrait
pip3 install -r /requirements.txt --extra-index-url ${INDEX_URL}

# Download checkpoints
huggingface-cli download KwaiVGI/LivePortrait \
  --local-dir pretrained_weights \
  --local-dir-use-symlinks False

# Deactivate venv
deactivate
