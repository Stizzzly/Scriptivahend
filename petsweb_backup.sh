#!/bin/bash

LOGFILE="$HOME/petsweb_logreport_$(date +%Y-%m-%d_%H_%M_%S).log"

BACKUP_DIR="$HOME/petsweb_backup"

mkdir -p "$BACKUP_DIR"

exec > >(tee -a "$LOGFILE") 2>&1

echo "==============================================="
echo " VARUNDAMISE SKRIPT KÄIVITATI: $(date)"
echo " Logifail: $LOGFILE"
echo "==============================================="
echo

echo "--- ESIMENE SIMULATSIOON ---"
sudo rsync -avhn --dry-run /var/www/petsweb/ "$BACKUP_DIR/"
echo

echo "--- PÄRIS SYNK VÄLISTUSTEGA ---"
sudo rsync -avh \
    --exclude="*.md" \
    --exclude="package.json" \
    --exclude="install.sh" \
    --exclude="tests/" \
    /var/www/petsweb/ "$BACKUP_DIR/"
echo

echo "--- SIHTKOHA STRUKTUUR ---"
ls -lR "$BACKUP_DIR"
echo

echo "Varundamine lõpetatud edukalt: $(date)"
