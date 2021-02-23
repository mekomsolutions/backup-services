#!/usr/bin/env bash

# Create database credentials file
cat > ~/.pgpass << EOF
${DB_HOST:-localhost}:${DB_PORT:-5432}:${DB_NAME}:${DB_USERNAME}:${DB_PASSWORD}
EOF
chmod 600 ~/.pgpass

# Wait for postgresql to initialize
/opt/wait-for-it.sh --timeout=3600 ${DB_HOST:-localhost}:${DB_PORT:-5432}

if [ "$( psql -h ${DB_HOST:-localhost} -U ${DB_USERNAME} -tAc "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" )" = '1' ]
then
    PG_PASSWORD="${DB_PASSWORD}" pg_dump -h ${DB_HOST:-localhost} -U ${DB_USERNAME} -d ${DB_NAME} > ${BACKUP_PATH:-/opt/backup}/${DB_NAME}-$(date +'%m-%d-%Y_%H:%M').dump
else
    echo "Database '${DB_NAME}' does not exist!"
    exit 1
fi
