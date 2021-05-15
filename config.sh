# specify ANDROID_HOSTS and ANDROID_PORTS to scan for a running adb server

# Can pass hostnames, IP addresses, networks, etc.
# Examples: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
ANDROID_HOSTS='10.0.0.4'

# TCP Ports or ranges.
# Examples:
ANDROID_PORTS='1024-65535'

#  Give up on target after this long
#  Options which take <time> are in seconds, or append 'ms' (milliseconds),
#  's' (seconds), 'm' (minutes), or 'h' (hours) to the value (e.g. 30m).
ANDROID_HOSTS_TIMEOUT='2m'

#
PATH="${PATH}:${HOME}/Android/Sdk/platform-tools"
