# adb wifi connect daemon

## short description
Easy and convenient way to auto-connect to your android phone with adb over WIFI in a daemon like way.

## System requirements
I tested this only on linux, but it should work macos too and maybe even on windows if you manage to install nmap and run bash scripts there.
The phone needs not be rooted for this to work!

## Usage

### 1. steps to execute on your android phone
1. Make sure you are a developer: Tap the build number seven times in Settings > About phone.
2. Enable Wireless Debugging in System > Developer Options.
3. Note down the IP address and port number that is displayed when being in Wireless Debugging menu (previous step).
4. Tap 'Pair device with paring code.'
5. Recommendation to avoid having to regular re-pair: Tap 'Disable adb authorisation timeout' in 'Developer Options' menu.

### 2. steps to execute on your computer
1. Install https://nmap.org/download.html and https://developer.android.com/studio and make sure the adb command is on the PATH!
2. `adb pair <your ip from step 1.3>:<your port from step 1.3>`, e.g. `adb pair 10.0.0.4:42707` and enter the pairing code (step 1.4).
3. Install this tool:
```shell script
git clone "https://github.com/gernotfeichter/adb-wifi-connect.d.git" "${HOME}/.adb-wifi-connect.d"
```
4. Configure this tool: Adapt file "${HOME}/.adb-wifi-connect.d", further docu within the file.
5. Run Android Studio or any IDE process you registered in the previous step (setting `REQUIRED_PROCESSES`).
5. Run this tool: 
```shell script
cd "${HOME}/.adb-wifi-connect.d" && ./run.sh
```
6. Wait a little, scanning a single ip over all ports takes about 30s, behold if you chose a range of ips!
7. Now you should see the device in the dropdown when opening Android Studio!

If you like what this did and want to connect permanently, add step 2.5 to your autostart, if you followed the conventions you should be ok to directly add "${HOME}/.adb-wifi-connect.d/daemon.sh" to your autostart!

## long description

### motivation
When enabling wireless debugging on android phones you get a dynamic debugging port per default.
Re-connecting becomes a burden, because the port number typically has to be re-typed on each new connect, this involves two manual steps:
1. opening the Wireless Debugging menu on your phone
2. typing the adb connect command with parameters obtained from the previous step

This is partially automated by this tool, such that step 1. is the only manual step that is required.

## description
Per default configuration, this tool automatically connects to previously paired devices given that:
* Android Studio is running (or any other configured IDE, see setting `REQUIRED_PROCESSES`)
* No other device is already connected

## license
GNU GENERAL PUBLIC LICENSE Version 2, see [LICENSE](LICENSE)
