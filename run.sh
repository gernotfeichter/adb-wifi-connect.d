#!/usr/bin/env bash

set -x
set -e
source ./config.sh

function anyRequiredProcessRunning() {
  for process in ${REQUIRED_PROCESSES}; do
    if pgrep -x "${process}" >/dev/null;
    then
      echo "true"
      return 0
    fi
  done
  echo "false"
}

function deviceOnlineCheck() {
  if [[ "${ONLY_SCAN_WHEN_NO_DEVICE_ONLINE}" = "true" ]]; then
    adb_devices_count="$(adb devices | grep device\$ | wc -l)"
    [[ ${adb_devices_count} = 0 ]] && echo "true" && return 0
    echo "false"
    return 0
  fi
  echo "true"
}

set +e
while true; do
  if [[ "$(anyRequiredProcessRunning)" = "true" ]] && [[ "$(deviceOnlineCheck)" = "true" ]]; then
    nmap_output="$(nmap "${ANDROID_HOSTS}" -p "T:${ANDROID_PORTS}" --max-retries 0 --host-timeout "${ANDROID_HOSTS_TIMEOUT}")"
    echo "nmap_output=${nmap_output}"
    while IFS= read -r line ; do
      if [[ "${line}" =~ ^Nmap\ scan\ report\ for.*\((.*)\)$ ]]; then
        current_host="${BASH_REMATCH[1]}"
      fi
      if [[ "${line}" =~ ^([[:digit:]]*)\/tcp.*open.*$ ]]; then
        current_port="${BASH_REMATCH[1]}"
        adb start-server
        adb connect "${current_host}:${current_port}"
      fi
  done <<< "${nmap_output}"
  fi

  sleep "${POLL_SLEEP_SECONDS}"
done
