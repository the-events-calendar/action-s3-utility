#!/bin/sh

set -e

the_command="aws s3 sync ${SOURCE_DIR:-.} s3://${S3_BUCKET}/${DEST_DIR} ${S3_PROFILE} --no-progress ${ENDPOINT_APPEND} $*"

echo $the_command

# Sync path.
sh -c $the_command
