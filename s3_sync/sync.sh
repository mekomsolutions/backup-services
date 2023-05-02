#!/bin/bash

set -e

echo "Started: $(date)"

/usr/local/bin/aws s3 sync $PARAMS "$DATA_PATH" "$S3_PATH"

echo "Finished: $(date)"