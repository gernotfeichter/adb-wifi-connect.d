#!/usr/bin/env bash
LOGFILE="${HOME}/.adb-wifi-connect.d/log"
cd "${HOME}/.adb-wifi-connect.d"
rm "${LOGFILE}"
./run.sh >"${LOGFILE}" 2>&1
