# specify ANDROID_HOSTS and ANDROID_PORTS to scan for a running adb server

# Can pass hostnames, IP addresses, networks, etc.
# Examples: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
# Hint: to support changing IP addresses, I recommend using hostnames, but this might not work for
# everyone: https://superuser.com/questions/408539/how-to-set-friendly-network-name-of-android-computer/1504366
# Other than that you may also use the IP and create a lease on your router!
ANDROID_HOSTS='10.0.0.3'

# TCP Ports or ranges.
# Examples:
ANDROID_PORTS='1024-65535'

# Give up scanning after this long
# Options which take <time> are in seconds, or append 'ms' (milliseconds),
# 's' (seconds), 'm' (minutes), 'h' (hours) or 'd' (days) to the value (e.g. 30m).
SCAN_TIMEOUT='1m'

# interval between scans
# lower is better for responsiveness but higher on network/cpu utilisation
POLL_SLEEP_SECONDS=5

# scan only when at least one of those processes are running (ADD your IDE process name here)
# if you want to scan always, you might choose the init process or systemd process
# note: fsnotifier is a subprocess of studio.sh and for some reason (most likely systemd reason)
# the studio.sh does not show up as process when saving studio.sh as desktop application launcher
# (at least on my current fedora/gnome combo)
REQUIRED_PROCESSES=( "studio.sh" "studio.exe" "studio.bat" "fsnotifier" "code")

# if ONLY_SCAN_WHEN_NO_DEVICE_ONLINE=true and 'adb devices' command lists at least one device: do
# not scan (save resources)
ONLY_SCAN_WHEN_NO_DEVICE_ONLINE=true

# nmaps timing template parameter
# see https://nmap.org/book/man-performance.html for details
# This default parameter is the slowest option of scanning
# The main reason for scanning slowly per default is that the network might become unresponsive
# (almost unusable), even in normal mode (at least in my home net).
NMAP_SCAN_MODE=normal
NMAP_MAX_RTT_TIMEOUT='1s'

# add adb to command path
ADB_FOLDER="${HOME}/Android/Sdk/platform-tools"
if [[ ! "${PATH}" =~ ${ADB_FOLDER} ]]; then
  PATH="${ADB_FOLDER}:${PATH}"
fi

