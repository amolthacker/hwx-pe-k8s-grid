#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/env.sh

LOG="$LOGS_BASE/valengine-prod.log"
tail -f $LOG
