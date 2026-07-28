#!/bin/bash

if command -v nvidia-smi >/dev/null 2>&1; then
    util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n 1)
    echo "GPU ${util}%"
else
    echo "GPU N/A"
fi
