#!/bin/bash

# Loome ajatempliga aruandefaili
ARUANDE_FAIL="health_report_$(date +%Y-%m-%d_%H%M).txt"

echo "--- SÜSTEEMI TERVISEARUANNE ---" > "$ARUANDE_FAIL"
echo "Genereeritud: $(date)" >> "$ARUANDE_FAIL"

echo "" >> "$ARUANDE_FAIL"
echo "--- KETTARUUMI KASUTUS (/) ---" >> "$ARUANDE_FAIL"
df -h / >> "$ARUANDE_FAIL"

echo "" >> "$ARUANDE_FAIL"
echo "--- UUENDATAVAD PAKETID ---" >> "$ARUANDE_FAIL"
sudo apt update > /dev/null 2>&1
UUENDUSI=$(apt list --upgradable 2>/dev/null | wc -l)
if [ "$UUENDUSI" -le 1 ]; then
    echo "Süsteem on ajakohane." >> "$ARUANDE_FAIL"
else
    UUENDUSI_ARV=$(($UUENDUSI - 1))
    echo "Uuendatavaid pakette: $UUENDUSI_ARV" >> "$ARUANDE_FAIL"
fi

echo "" >> "$ARUANDE_FAIL"
echo "--- RSYNC VARUKOOPIA STAATUS (~/petsweb_backup) ---" >> "$ARUANDE_FAIL"
if [ -f ~/petsweb_backup/index.html ]; then
    echo "KORRAS" >> "$ARUANDE_FAIL"
else
    echo "VIGA VÕI PUUDUB!" >> "$ARUANDE_FAIL"
fi

echo "" >> "$ARUANDE_FAIL"
echo "--- TAR VARUKOOPIA STAATUS (~/backup) ---" >> "$ARUANDE_FAIL"
VIIMANE_TAR=$(find ~/backup -name "petsweb_*.tar.gz" -mmin -1440 | head -n 1)
if [ -n "$VIIMANE_TAR" ]; then
    echo "Ajakohane varukoopia leitud: $VIIMANE_TAR" >> "$ARUANDE_FAIL"
else
    echo "Ajakohane varukoopia puudub!" >> "$ARUANDE_FAIL"
fi

echo "" >> "$ARUANDE_FAIL"
echo "--- ARUANDE LÕPP ---" >> "$ARUANDE_FAIL"

echo "Tervisekontrolli aruanne on salvestatud faili: $ARUANDE_FAIL"
