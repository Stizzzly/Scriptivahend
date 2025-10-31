#!/bin/bash

# Loo sihtkaust, kui seda pole
mkdir -p ~/petsweb_backup
LOGFILE="petsweb_logreport_$(date +%Y-%m-%d_%H_%M_%S).log"

echo "--- ESIMENE SIMULATSIOON ---" > $LOGFILE
sudo rsync -avhn /var/www/petsweb/ ~/petsweb_backup/

echo "--- PÄRIS SYNK VÄLISTUSTEGA ---" > $LOGFILE
sudo rsync -avh \
    --exclude="*.md" \
    --exclude="package.json" \
    --exclude="install.sh" \
    --exclude="tests/" \
    /var/www/petsweb/ ~/petsweb_backup/

echo "--- SIHTKOHA STRUKTUUR ---" > $LOGFILE
ls -lR ~/petsweb_backup

echo "Varundamine lõpetatud."
