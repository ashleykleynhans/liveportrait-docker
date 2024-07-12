#!/usr/bin/env bash

echo "Starting LivePortrait"
source /venv/bin/activate
cd /workspace/LivePortrait
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"
export PYTHONUNBUFFERED=1
nohup python3 app.py --server_name 0.0.0.0 --server_port 3001 > /workspace/logs/LivePortrait.log 2>&1 &
echo "LivePortrait started"
echo "Log file: /workspace/logs/LivePortrait.log"
deactivate
