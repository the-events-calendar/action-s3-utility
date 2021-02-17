#!/bin/sh

set -e

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

# Verify file existence.
output=$(sh -c "aws s3 rm s3://${S3_BUCKET}/${FILE} $S3_PROFILE $ENDPOINT_APPEND $*")

echo $output

echo "::set-output name=value::${output}"
