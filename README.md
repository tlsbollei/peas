
<h1 align="center">
  <br>
  <img src=https://raw.githubusercontent.com/tlsbollei/peas/refs/heads/main/assets/c772b8b3-5f97-4b0f-ad07-1f6f6fd9ef5e.png alt="Linux Peas" width="200"></a>
  <br>
  ctPEASf - lightweight privesc tool for CTFs
  <br>
</h1>

<p align="left">
  ctfPEASf has been developed as a personal project after countless jeopardy CTF competitions and root2boot exercises. Up until a certain point in time I have been constantly using LinPeas, whose obnoxious verbosity, weight on the target system, slow execution and annoying dependencies have provided for a miserable CTF experience. That is precisely why I have created ctPEASf -> a lightweight, small privilege escalation framework. I have fed this bash script continous new checks after seeing them in their respective CTFs. I plan on enhancing ctPEASf as my experience with boot2root and privilege escalation CTFs grow.
  <a href="http://electron.atom.io" target="_blank"></a>
</p>





[![first-timers-only](https://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square)](https://www.firsttimersonly.com/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)
[![Discord](https://img.shields.io/badge/Discord-7289DA?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/MqqPYJ2s)


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
* Shows the groups the user belongs to.
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

 ## As of the 17th of June 2025, ctPEASf has gained the following functionalities ->

* Generally checks for containerization context (docker,lxc,kubepods) by reading from ```/proc/1/cgroup```
* Checks for passwordless sudo auth using ```sudo -n true``` and capturing shell result output
* Checks for writable PATH variables
* Hunts down users assigned a real shell after strict filtering
* Looks for an exposed docker socket at ```/var/run/docker.sock```, checks its readability



## How To Use



```bash
$ wget https://raw.githubusercontent.com/tlsbollei/peas/main/peas.sh -O ctpeasf.sh 
$ chmod +x peas.sh
$ ./peas.sh
```

## Dependencies
* On Debian/Ubuntu :
```bash
sudo apt update && sudo apt install -y exploitdb net-tools iproute2 findutils grep coreutils
```

## Where ctPEASf has been used, so far, with efficient results

* CyberGame 2025, which serves at the national qualifier for Team Slovakia, has had a CTF task with an exposed docker socket. Using prototyped logic from ctPEASf, I have successfuly identified the exposed docker socket and created an escape container.
* VulnHub "Docker:1"
* TryHackMe “Wonderland” CTF -> malicious code injection via PATH









## You may also like...

- [Web Application vulnerability scanning](https://github.com/tlsbollei/webapp-vulnscan-tool) - A script written in bash designed for scanning for known vulnerabilities of web applications
- [Check for SSH misconfigurations](https://github.com/tlsbollei/buniatko) - A script written in bash designed to check for Secure Shell misconfigurations (weak cipher, root login, empty credentials...)



