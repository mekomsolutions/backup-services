#!/usr/bin/env sh

cd ${FILESTORE_PATH} && zip -r ${BACKUP_PATH:-/opt/backup}/filestore-$(date +'%Y-%m-%d_%H-%M').zip ./
