#!/usr/bin/env bash

# Script per aggiornare gli URL di WordPress nel database
# Uso: ./bin/update-site-url.sh OLD_URL NEW_URL

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 OLD_URL NEW_URL"
    echo "Esempio: $0 http://127.0.0.1:31337 http://YOUR_PUBLIC_IP:31337"
    exit 1
fi

OLD_URL=$1
NEW_URL=$2

echo "Aggiornamento URL da $OLD_URL a $NEW_URL..."

# Aggiorna le opzioni di WordPress
wp option update home "$NEW_URL" --skip-themes --skip-plugins
wp option update siteurl "$NEW_URL" --skip-themes --skip-plugins

# Search and replace nel database
wp search-replace "$OLD_URL" "$NEW_URL" --skip-columns=guid --skip-themes --skip-plugins

echo "✓ URL aggiornato con successo!"
