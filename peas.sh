#!/bin/bash
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
NC=$'\e[0m'  


echo -e "${GREEN}"


read -p "Press enter to continue with the script..."


echo "${YELLOW}[*] checking for kernel exploits..."
KERNEL=$(uname -r)
if command -v searchsploit &> /dev/null; then
    searchsploit --color linux kernel | grep -i "$KERNEL" || echo "${RED}[-] no  kernel exploits found for $KERNEL."
else
    echo "${RED}[-] searchsploit not found. skipping kernel exploit check."
fi

echo "${YELLOW}[*] checking containerization context..."
grep -qaE 'docker|lxc|kubepods' /proc/1/cgroup && echo "${GREEN}[+] detected container environment in /proc/1/cgroup"


## 
echo "${YELLOW}[*] checking sudo permissions using sudo -n true..."
if sudo -n true 2>/dev/null; then
    echo "${GREEN}[+] passwordless sudo is enabled, test-authed with sudo result 0."
    sudo -l
else
    sudo -l 2>/dev/null || echo "${RED}[-] cannot list sudo permissions (no access)."
fi

echo "${YELLOW}[*] checking for writable PATH variables"
IFS=':' read -ra PATH_DIRS <<< "$PATH" # create a split array from paths, -r to not interpret backslashes
for dir in "${PATH_DIRS[@]}"; do
    if [ -w "$dir" ]; then
        echo "${GREEN}[+] writable directory in PATH: $dir"
    fi
done

# checks accounts with uid >= 1000 (mostly user accounts above) and filtering out login, includes only users assigned a real shell
echo "${YELLOW}[*] checking /etc/passwd for shell-enabled users..."

awk -F: '($3 >= 1000 && $7 != "/usr/sbin/nologin" && $7 != "/bin/false") { print $1 ":" $7 }' /etc/passwd



echo "${YELLOW}[*] checking for exposed docker socket in /var/run... (note that if this machine has an exposed docker socket, it may not lie in /var/run"
if [ -S /var/run/docker.sock ]; then
    if [ -r /var/run/docker.sock ]; then
        echo "${GREEN}[+] docker socket exists and is readable."
        echo "${GREEN}[!] consider creating a host breakout container"
    else
        echo "${RED}[-] docker socket exists but is not readable by current user."
    fi
else
    echo "${RED}[-] no docker socket found."
fi

grep -qa docker /proc/1/cgroup && echo "${GREEN}[+] you're in a Docker container."

echo "${YELLOW}[*] searching for SUID binaries..."
SUID_FILES=$(find / -perm -4000 -type f 2>/dev/null)
if [ -z "$SUID_FILES" ]; then
    echo "${RED}[-] no SUID files found."
else
    echo "${GREEN}[+] found SUID binaries:"
    echo "$SUID_FILES" | tee suid_files.txt
    echo "${GREEN}[!] investigate further."
fi


echo "${YELLOW}[*] searching for world-writable files and directories..."
WRITABLE_FILES=$(find / -writable -type f 2>/dev/null)
if [ -z "$WRITABLE_FILES" ]; then
    echo "${RED}[-] no writable files found."
else
    echo "${GREEN}[+] found writable files:"
    echo "$WRITABLE_FILES" | tee writable_files.txt
    echo "${GREEN}[!] investigate further."
fi


echo "${YELLOW}[*] checking current user and groups..."
id
echo "${GREEN}[+] user belongs to the following groups:"
groups



echo "${YELLOW}[*] checking for sensitive environmental variables..."
env | grep -iE '(password|secret|key|token|credential)' || echo "${RED}[-] No sensitive variables found."



echo "${YELLOW}[*] checking for mounted file systems..."
MOUNTED=$(mount | grep -v 'proc\|sysfs\|tmpfs')
if [ -z "$MOUNTED" ]; then
    echo "${RED}[-] no significant mounted file systems found."
else
    echo "${GREEN}[+] found mounted file systems:"
    echo "$MOUNTED"
    echo "${GREEN}[!] Check for misconfigured mount options (e.g., noexec, nosuid, nodev)"
fi



echo "${YELLOW}[*] checking for processes running as root..."
ROOT_PROCESSES=$(ps aux | grep root | grep -v grep)
if [ -z "$ROOT_PROCESSES" ]; then
    echo "${RED}[-] no root processes found."
else
    echo "${GREEN}[+] found processes running as root:"
    echo "$ROOT_PROCESSES"
    echo "${GREEN}[!] investigate further."
fi



echo "${YELLOW}[*] checking open ports..."
ss -tuln || netstat -tuln
echo "${GREEN}[!] investigate open ports for vulnerable services."
echo "${YELLOW}[*] checking active network connections..."
ss -tpn || netstat -tpn


echo "${YELLOW}[*] searching for sensitive files..."
SENSITIVE_FILES=("/etc/passwd" "/etc/shadow" "/root/.ssh" "/var/log/auth.log")
for FILE in "${SENSITIVE_FILES[@]}"; do
    if [ -e "$FILE" ]; then
        echo "${GREEN}[+] found: $FILE"
        ls -l "$FILE"
    else
        echo "${RED}[-] $FILE not found."
    fi
done



echo "${YELLOW}[*] checking history files for stored commands..."
HISTORY_FILES=("$HOME/.bash_history" "$HOME/.zsh_history" "/root/.bash_history" "/root/.zsh_history")
for HISTORY in "${HISTORY_FILES[@]}"; do
    if [ -e "$HISTORY" ]; then
        echo "${GREEN}[+] found: $HISTORY"
        cat "$HISTORY" | tail -n 20
    else
        echo "${RED}[-] $HISTORY not found."
    fi
done


echo "${YELLOW}[*] searching for sticky bit files..."
STICKY_FILES=$(find / -type f -perm -1000 2>/dev/null)
if [ -z "$STICKY_FILES" ]; then
    echo "${RED}[-] no sticky bit files found."
else
    echo "${GREEN}[+] found sticky bit files:"
    echo "$STICKY_FILES"
    echo "${GREEN}[!] check these files for misconfigurations that might allow privilege escalation."
fi



echo "${YELLOW}[*] checking for writable /etc/hosts or /etc/hostname..."
for FILE in "/etc/hosts" "/etc/hostname"; do
    if [ -w "$FILE" ]; then
        echo "${GREEN}[+] $FILE is writable by the user."
    else
        echo "${RED}[-] $FILE is not writable."
    fi
done


