#!/usr/bin/env bash
LOGFILE="${HOME}/.adb-wifi-connect.d/log"
rm LOGFILE
cd "${HOME}/.adb-wifi-connect.d"
./run.sh >"${LOGFILE}" 2>&1
