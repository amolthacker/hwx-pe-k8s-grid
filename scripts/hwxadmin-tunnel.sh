#!/bin/bash

socket=$HOME/.ssh/hwxadmin-tunnel.ctl

if [ "$1" == "start" ]; then
  if [ ! \( -e ${socket} \) ]; then
    echo "Starting tunnel to Admin VM ..."
    ssh -f -N hwxadmin-start && echo "Done."
  else
    echo "Tunnel to Admin VM running."
  fi
fi

if [ "$1" == "stop" ]; then
  if [ \( -e ${socket} \) ]; then
    echo "Stopping tunnel to Admin VM ..."
    ssh -O "exit" hwxadmin-stop && echo "Done."
  else
    echo "Tunnel to Admin VM stopped."
  fi
fi
