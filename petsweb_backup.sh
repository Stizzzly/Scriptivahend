#!/bin/bash

# Loo sihtkaust, kui seda pole
mkdir -p ~/petsweb_backup

# Loo logifail
LOGFILE="~/petsweb_backup/petsweb_logreport_$(date +%Y-%m-%d_%H_%M_%S).log"
# Bash ei asenda ~ kui see on jutumärkides, seega vaja teha nii:
LOGFILE="$HOME/petsweb_backup/petsweb_logreport_$(date +%Y-%m-%d_%H_%M_%S).log"

{
echo "--- ESIMENE SIMULATSIOON ---"
sudo rsync -avhn --dry-run /var/www/petsweb/ "$HOME/petsweb_backup/"

echo
echo "--- PÄRIS SYNK VÄLISTUSTEGA ---"
sudo rsync -avh \
    --exclude="*.md" \
    --exclude="package.json" \
    --exclude="install.sh" \
    --exclude="tests/" \
    /var/www/petsweb/ "$HOME/petsweb_backup/"

echo
echo "--- SIHTKOHA STRUKTUUR ---"
ls -lR "$HOME/petsweb_backup"

echo
echo "Varundamine lõpetatud."
} | tee "$LOGFILE"
