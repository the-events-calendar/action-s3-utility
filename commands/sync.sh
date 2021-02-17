#!/bin/sh

set -e

the_command="aws ${S3_PROFILE} ${ENDPOINT_APPEND} s3 sync ${SOURCE_DIR:-.} s3://${S3_BUCKET}/${DEST_DIR} --no-progress $*"

echo $the_command

# Sync path.
sh -c "$the_command"
