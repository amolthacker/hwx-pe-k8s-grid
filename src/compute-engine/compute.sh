#!/bin/bash

usage(){
	echo "Usage: $0 <metric> <numTrades>"
	exit 1
}


[[ $# -ne 2 ]] && usage

# Which java to use
if [ -z "$JAVA_HOME" ]; then
  JAVA="java"
else
  JAVA="$JAVA_HOME/bin/java"
fi

LIB_PATH=/usr/local/lib

cmd="$JAVA -Djava.library.path=$LIB_PATH -jar $LIB_PATH/mockvalengine-0.1.0.jar $1 $2"

exec $cmd

