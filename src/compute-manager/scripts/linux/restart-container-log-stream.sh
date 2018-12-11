#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/env.sh

echo "Killing existing kubetail procs ..."
kkill kubetail
sleep 1
echo "Killing existing websocketd procs ..."
kkill websocketd
sleep 1
echo "Tailing valengine-prod container logs ..."
kubetail valengine-prod > $LOGS_BASE/valengine-prod.log 2>&1&
sleep 1
echo "Starting websocketd proc on 8888 ..."
nohup websocketd --port=8888 --devconsole stream-container-logs > $LOGS_BASE/start-container-logs-stream.log 2>&1&
