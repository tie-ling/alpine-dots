#!/bin/sh
if [ "${1}" == "pre" ]; then
  touch /tmp/swaylock-sleep
  sleep 1
fi
