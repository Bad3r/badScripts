#! /bin/bash
: <<'EOF'
Discription: 
Usage......:
EOF

# 0 0 10,15/12 * * /home/laurent/scripts/joplin_notes_backup.sh >> /var/log/joplin_bak.log 2>&1

BACKUP_DIR="/path/to/backup_dir"
# JOPLIN_BIN="$HOME/.npm-global/bin/joplin"
JOPLIN_BIN="/usr/bin/joplin"

$JOPLIN_BIN sync
$JOPLIN_BIN e2ee decrypt

cd "$BACKUP_DIR"
rm -f *.md
rm -f resources/*
$JOPLIN_BIN --log-level debug export --format raw "$BACKUP_DIR"
git add .
git commit -m "Update"