#!/usr/bin/env sh

zip -r ${BACKUP_PATH:-/opt/backup}/$(date +'%m-%d-%Y_%H:%M').zip ${FILESTORE_PATH}
