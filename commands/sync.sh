#!/bin/sh

set -e

# Sync path.
sh -c "aws s3 sync ${SOURCE_DIR:-.} s3://${S3_BUCKET}/${DEST_DIR} --profile action-s3-utility --no-progress ${ENDPOINT_APPEND} $*"
