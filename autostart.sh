#!/usr/bin/env bash
LOGFILE="${HOME}/.adb-wifi-connect.d/log"
rm LOGFILE
cd "${HOME}/.adb-wifi-connect.d" && source ./run.sh 2>&1 >"${LOGFILE}"
