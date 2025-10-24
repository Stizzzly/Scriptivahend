#!/bin/bash

# Loome ajatempliga logifaili
LOGFILE="ngx_logreport_$(date +%Y-%m-%d_%H_%M_%S).log"

echo "--- NGINXI LOGIDE ANALÜÜS ---" > "$LOGFILE"

echo "" >> "$LOGFILE"
echo "--- AKTIIVSED NGINXI PROTSESSID ---" >> "$LOGFILE"
ps aux | grep nginx >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "--- LEITUD 404 VEAD (access.log) ---" >> "$LOGFILE"
sudo cat /var/log/nginx/access.log | grep " 404 " >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "--- 404 VIGADE KOGUARV ---" >> "$LOGFILE"
sudo cat /var/log/nginx/access.log | grep " 404 " | wc -l >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "--- KRIITILISED VEAD (error.log) ---" >> "$LOGFILE"
sudo cat /var/log/nginx/error.log | grep "crit" >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "--- ANALÜÜSI LÕPP ---" >> "$LOGFILE"

echo "Aruanne salvestatud faili: $LOGFILE"
