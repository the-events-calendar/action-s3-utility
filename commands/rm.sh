#!/bin/sh

set -e

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

the_command="aws s3 rm s3://${S3_BUCKET}/${FILE} ${S3_PROFILE} ${ENDPOINT_APPEND} $*"

echo $the_command

# Verify file existence.
output=$(sh -c $the_command)

echo $output

echo "::set-output name=value::${output}"
