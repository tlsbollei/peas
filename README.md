
<h1 align="center">
  <br>
  <img src=https://raw.githubusercontent.com/tlsbollei/peas/refs/heads/main/assets/kaneki.jpg alt="Linux Peas" width="200"></a>
  <br>
  Linux Peas
  <br>
</h1>

<h4 align="center">Linux Privilege Escalation checker <a href="http://electron.atom.io" target="_blank"></a></h4>

[![first-timers-only](https://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square)](https://www.firsttimersonly.com/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)


<p align="center">
  <a href="#key-features">Key Features</a> 
  <a href="#how-to-use">How To Use</a> 

![screenshot](https://raw.githubusercontent.com/tlsbollei/peas/refs/heads/main/assets/peas.gif)

[![forthebadge](https://forthebadge.com/images/featured/featured-built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/featured/featured-gluten-free.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/featured/featured-oooo-kill-em.svg)](https://forthebadge.com)
## Key Features

* The script checks the current kernel version ```(uname -r).```
* Searches for known kernel exploits related to the identified version using searchsploit.
* Searches for files with the SUID bit set ```(find / -perm -4000).```
* Lists and logs these binaries into a file (suid_files.txt).
* Provides guidance for further investigation of potentially exploitable binaries.
* Scans for world-writable files and directories ```(find / -writable).```
* Outputs the list of these files and suggests investigation for privilege escalation risks.
* Displays the current user details  ( ```id ``` and  ```groups ``` commands).
* Shows the groups the user belongs to, aiding in the identification of potential misconfigurations.
* Checks for sensitive environment variables related to passwords, tokens, keys, and credentials using  ```env | grep -iE '(password|secret|key|token|credential)' ```.
* Lists non-standard mounted file systems  ```(mount | grep -v 'proc\|sysfs\|tmpfs') ```.
* Flags potentially insecure mount options (e.g., noexec, nosuid, nodev) that could be exploited for privilege escalation.
* Searches for processes running as root   ( ```ps aux | grep root ```).
* Outputs details of root processes for possible privilege escalation points.
* Displays open network ports and active connections using  ```ss ``` or  ```netstat ```.
* Searches for critical system files such as ``` /etc/passwd ```,  ```/etc/shadow ```, and ```/root/.ssh ``` that may contain sensitive information. 
* Checks for history files that might contain sensitive commands or credentials ( ```~/.bash_history ```, ``` ~/.zsh_history ```).
* Searches for files with the sticky bit set ( ```find / -type f -perm -1000 ```).
* Checks if critical system files like  ```/etc/hosts ``` and  ```/etc/hostname ``` are writable by the current user.


## How To Use



```bash
# Give permissions
$ chmod +x peas.sh

# Run the script
$ ./peas.sh

or

# Run the script
$ bash peas.sh
```

## Dependencies


* On Debian/Ubuntu :
  ```bash
  sudo apt update
  sudo apt install exploitdb
  sudo apt install net-tools
  sudo apt install iproute2
  sudo apt install findutils
  sudo apt install grep
  sudo apt install coreutils


  ```
* On RedHat/CentOs :
  ```bash
  sudo yum install exploitdb
  sudo yum install net-tools
  sudo yum install iproute
  sudo yum install findutils
  sudo yum install grep
  sudo yum install coreutils

  ```
* On Arch Linux :
  ```bash
  sudo pacman -S exploitdb
  sudo pacman -S net-tools
  sudo pacman -S iproute2
  sudo pacman -S findutils
  sudo pacman -S grep
  sudo pacman -S coreutils



  ```
  








## You may also like...

- [Web Application vulnerability scanning](https://github.com/tlsbollei/webapp-vulnscan-tool) - A script written in bash designed for scanning for known vulnerabilities of web applications
- [Check for SSH misconfigurations](https://github.com/tlsbollei/buniatko) - A script written in bash designed to check for Secure Shell misconfigurations (weak cipher, root login, empty credentials...)



> GitHub [tlsbollei](https://github.com/tlsbollei) &nbsp;&middot;&nbsp;
> Instagram [0fa102](https://www.instagram.com/0fa102/)
> Discord [0fa](https://discord.com/channels/@me)
> Telegram [boleii655](https://t.me/boleii655)

