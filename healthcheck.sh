#!/bin/bash

LOG_FILE="/var/log/server_health.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

{
    echo "=========================================="
    echo "Отчет о состоянии сервера: $DATE"
    echo "Uptime: $(uptime -p)"
    echo "Нагрузка CPU (Load Average): $(awk '{print $1, $2, $3}' /proc/loadavg)"
    echo "Память (RAM): $(free -h | awk 'NR==2 {print $3 " использовано из " $2}')"
    echo "Диск (/): $(df -h / | awk 'NR==2 {print $3 " использовано из " $2 " (" $5 ")"}')"
    echo "Статус SSHD: $(systemctl is-active sshd)"
    echo "Статус Firewalld: $(systemctl is-active firewalld)"
    echo "=========================================="
    echo ""
} >> "$LOG_FILE"
