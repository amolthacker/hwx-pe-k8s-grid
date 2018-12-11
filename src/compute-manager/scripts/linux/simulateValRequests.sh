#!/bin/bash

usage(){
	echo "Usage: $0 <clientId> <numValReq>"
	exit 1
}


[[ $# -ne 2 ]] && usage

BASE_DIR="$(dirname $0)"
source $BASE_DIR/env.sh

progPath="$COMPUTE_BASE/compute-engine/eodservice.go"
logsPath="$LOGS_BASE"

clientId=$1
numValReq=$2

# K8S agent nodes DNS/PIP
dns="hwx-pe.eastus.cloudapp.azure.com"

metrics=( "ParRate" "NPV" "IRDelta" )

for i in "${metrics[@]}"
do
	nohup go run $progPath $clientId $dns $i $numValReq > $logsPath/eodservice.$clientId.log &
done
