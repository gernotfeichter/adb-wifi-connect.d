#!/usr/bin/env bash

echo "run.sh started"

set -x
set -e

function anyRequiredProcessRunning() {
  for process in ${REQUIRED_PROCESSES}; do
    if pgrep -x "${process}" >/dev/null; then
      echo "true"
      return 0
    fi
  done
  echo "false"
}

function deviceOfflineCheck() {
  if [[ "${ONLY_SCAN_WHEN_NO_DEVICE_ONLINE}" == "true" ]]; then
    adb_devices_count="$(adb devices | grep device\$ | wc -l)"
    [[ ${adb_devices_count} == 0 ]] && echo "true" && return 0
    echo "false"
    return 0
  fi
  echo "true"
}

# if you followed the README.md, the parent would be daemon.sh
# if the daemon was killed, we (=subprocess of daemon) also want to die
function dieIfMyParentDied() {
  ps -p "${PPID}" > /dev/null
  parent_running_check_exit_code=$?
  if [[ ${parent_running_check_exit_code} != 0 ]]; then
    exit 0
  fi
}

set +e
while true; do
  source ./config.sh
  if [[ "$(anyRequiredProcessRunning)" == "true" ]] && [[ "$(deviceOfflineCheck)" == "true" ]]; then
    nmap_output="$(timeout "${SCAN_TIMEOUT:-2m}" nmap "${ANDROID_HOSTS}" -p "T:${ANDROID_PORTS}" -T "${NMAP_SCAN_MODE}" -Pn)"
    echo "nmap_output=${nmap_output}"
    while IFS= read -r line; do
      if [[ "${line}" =~ ^Nmap\ scan\ report\ for.*\((.*)\)$ ]]; then
        # style with hostname
        current_host="${BASH_REMATCH[1]}"
      fi
      if [[ "${line}" =~ ^Nmap\ scan\ report\ for\ ([[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+)$ ]]; then
        # style without hostname
        current_host="${BASH_REMATCH[1]}"
      fi
      if [[ "${line}" =~ ^([[:digit:]]*)\/tcp.*open.*$ ]]; then
        current_port="${BASH_REMATCH[1]}"
        adb start-server
        adb connect "${current_host}:${current_port}"
      fi
    done <<<"${nmap_output}"
  fi
  dieIfMyParentDied
  sleep "${POLL_SLEEP_SECONDS}"
done
