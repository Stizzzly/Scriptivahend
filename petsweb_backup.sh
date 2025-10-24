#!/bin/bash

# Loo sihtkaust, kui seda pole
mkdir -p ~/petsweb_backup

echo "--- ESIMENE SIMULATSIOON ---"
sudo rsync -avhn /var/www/petsweb/ ~/petsweb_backup/

echo "--- PÄRIS SYNK VÄLISTUSTEGA ---"
sudo rsync -avh \
    --exclude="*.md" \
    --exclude="package.json" \
    --exclude="install.sh" \
    --exclude="tests/" \
    /var/www/petsweb/ ~/petsweb_backup/

echo "--- SIHTKOHA STRUKTUUR ---"
ls -lR ~/petsweb_backup

echo "Varundamine lõpetatud."
