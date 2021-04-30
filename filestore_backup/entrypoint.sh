#!/usr/bin/env sh

zip -r ${BACKUP_PATH:-/opt/backup}/$(date +'%Y-%m-%d_%H-%M').zip ${FILESTORE_PATH}
