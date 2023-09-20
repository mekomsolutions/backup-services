#!/bin/bash

set -e

echo "Started: $(date)"

/usr/local/bin/aws s3 sync $PARAMS "$S3_PATH" "$DATA_PATH"

echo "Finished: $(date)"