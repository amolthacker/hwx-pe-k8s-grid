#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/env.sh

cd "$COMPUTE_BASE/compute-manager"
nohup go run ComputeManager.go > $LOGS_BASE/ComputeManager.log 2>&1&
