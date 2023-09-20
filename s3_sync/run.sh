#!/bin/bash

set -e

: ${S3_PATH:?"S3_PATH env variable is required"}
export DATA_PATH=${DATA_PATH:-/data/}
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-1}
CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
LOGFIFO='/var/log/cron.fifo'
if [[ ! -e "$LOGFIFO" ]]; then
    mkfifo "$LOGFIFO"
fi
CRON_ENV="PARAMS='$PARAMS'"
CRON_ENV="$CRON_ENV\nDATA_PATH='$DATA_PATH'"
CRON_ENV="$CRON_ENV\nS3_PATH='$S3_PATH'"
CRON_ENV="$CRON_ENV\nAWS_DEFAULT_REGION='$AWS_DEFAULT_REGION'"
CRON_ENV="$CRON_ENV\nAWS_ACCESS_KEY_ID='$AWS_ACCESS_KEY_ID'"
CRON_ENV="$CRON_ENV\nAWS_SECRET_ACCESS_KEY='$AWS_SECRET_ACCESS_KEY'"
if [[ "$1" == 'no-cron' ]]; then
    exec /sync.sh
elif [[ "$1" == 'get' ]]; then
    exec /get.sh
elif [[ "$1" == 'cron-get' ]]; then
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /get.sh > $LOGFIFO 2>&1" | crontab -
    cron
    tail -f "$LOGFIFO"
else
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /sync.sh > $LOGFIFO 2>&1" | crontab -
    cron
    tail -f "$LOGFIFO"
fi