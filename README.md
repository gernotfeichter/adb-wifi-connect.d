# adb wifi connect daemon

> Note: since adb version 35, there is built-in support in android studio to auto-connect via adb to your android phone, which makes this tool obsolete!
> However, since I could not quickly get this running outside of android studio, e.g. via command line, maybe this tool has some extened life.

## short description
Easy and convenient way to auto-connect to your android phone with adb over WIFI in a daemon like way.

## System requirements

### client (development machine)
<table>
    <thead>
        <th>OS</th>
        <th>Supported</th>
    </thead>
    <tbody>
        <tr>
            <td><img alt="Linux" src="https://github.com/EgoistDeveloper/operating-system-logos/blob/master/src/48x48/LIN.png"/></td>
            <td>yes</td>
        </tr>
        <tr>
            <td><img alt="macOS" src="https://github.com/EgoistDeveloper/operating-system-logos/blob/master/src/48x48/MAC.png"/></td>
            <td>should work(happy about user feedback)</td>
        </tr>
        <tr>
            <td><img alt="Windows" src="https://github.com/EgoistDeveloper/operating-system-logos/raw/master/src/48x48/WIN.png"/></td>
            <td>could work(happy about user feedback)</td>
        </tr>
    </tbody>
</table>

### server (android phone)

<table>
    <thead>
        <th>OS</th>
        <th>Supported</th>
    </thead>
    <tbody>
        <tr>
            <td><img alt="Android" src="https://github.com/EgoistDeveloper/operating-system-logos/raw/master/src/48x48/AND.png"/></td>
            <td>Any android version that supports wireless debugging should work. The phone needs NOT be rooted!</td>
        </tr>
    </tbody>
</table>

## Usage

### 1. steps to execute on your android phone
1. Make sure you are a developer: Tap the build number seven times in Settings > About phone.
2. Enable Wireless Debugging in System > Developer Options.
3. Note down the IP address and port number that is displayed when being in Wireless Debugging menu (previous step).
4. Tap 'Pair device with paring code.'
5. Recommendation to avoid having to regularly re-pair: Tap 'Disable adb authorisation timeout' in 'Developer Options' menu.

### 2. steps to execute on your development machine
1. Install https://nmap.org/download.html and https://developer.android.com/studio and make sure the adb command is on the PATH!
2. `adb pair <your ip from step 1.4>:<your port from step 1.4>`, e.g. `adb pair 10.0.0.4:42707` and enter the pairing code (step 1.4).
3. Install this tool:
```shell script
git clone "https://github.com/gernotfeichter/adb-wifi-connect.d.git" "${HOME}/.adb-wifi-connect.d"
```
4. Configure this tool: Edit the file "${HOME}/.adb-wifi-connect.d/config.sh" and set the ANDROID_HOSTS to the correct IP of the device (from step 1.3). Further docu within the file.
5. Run Android Studio or any IDE process you registered in the previous step (setting `REQUIRED_PROCESSES`).
6. Run this tool: 
```shell script
cd "${HOME}/.adb-wifi-connect.d" && ./run.sh
```
7. Wait a little, scanning a single ip over all ports takes about 30s, behold if you chose a range of ips!
8. Now you should see the device in the dropdown when opening Android Studio!

If you like what this did and want to connect permanently, add step 2.6 to your autostart.
In case you followed the conventions you should be able to directly add "${HOME}/.adb-wifi-connect.d/daemon.sh" to your autostart!

### troubleshooting

#### logs
Check the log file:
```shell script
tail -F ~/.adb-wifi-connect.d/log
```

#### kill processes
this kills the daemon:
```shell script
pkill -f .adb-wifi-connect.d
```
the daemon however spans another subprocess (`run.sh` script), it should die soon after the daemon
was killed.

## long description

### motivation
When enabling wireless debugging on android phones you get a dynamic debugging port per default.
Re-connecting becomes a burden, because the port number typically has to be re-typed on each new connect, this involves two manual steps:
1. opening the Wireless Debugging menu on your phone and enabling wireless debugging
2. typing the adb connect command with parameters obtained from the previous step

This is partially automated by this tool, such that step 1. is the only manual step that is required.

### description
Per default configuration, this tool automatically connects to previously paired devices given that:
* Android Studio is running (or any other configured IDE, see setting `REQUIRED_PROCESSES`)
* No other device is already connected

## license
GNU GENERAL PUBLIC LICENSE Version 2, see [LICENSE](LICENSE)
