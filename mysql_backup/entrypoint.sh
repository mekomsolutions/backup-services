#!/usr/bin/env sh

# Create datbase credentials file
mkdir -p /etc/mysql/ && touch /etc/mysql/db-credentials.cnf
cat > /etc/mysql/db-credentials.cnf << EOF
[client]
user=${DB_USERNAME}
password=${DB_PASSWORD}
EOF


# Wait for mysql to initialise
/opt/wait-for-it.sh --timeout=3600 ${DB_HOST:-localhost}:${DB_PORT:-3306}

# Checking if the database is already available
db_tables_count=`mysql --defaults-extra-file=/etc/mysql/db-credentials.cnf -h${DB_HOST:-localhost} --skip-column-names -e "SELECT count(*) FROM information_schema.tables WHERE table_schema = '${DB_NAME}'"`

if [ ${db_tables_count} -gt -1 ]; then
mysqldump --defaults-extra-file=/etc/mysql/db-credentials.cnf --host ${DB_HOST:-localhost} $DB_NAME > "${BACKUP_PATH:-/opt/backup}/${DB_NAME}-$(date +'%Y-%m-%d_%H-%M').sql"
fi
