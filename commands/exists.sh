#!/bin/sh

set -e

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

echo "Checking for file existence at s3://${S3_BUCKET}/${FILE} at the ${S3_ENDPOINT}"

# Verify file existence.
sh -c "aws s3api head-object --bucket ${S3_BUCKET} --key ${FILE} $S3_PROFILE $ENDPOINT_APPEND $*"

# XXX: we are just checking the error code, but should check the result for a 404, and raise error in other cases
if [ $? == 0 ]
then
  echo "File exists."
  echo "::set-output name=exists::true"
else
  echo "File does not exist."
  echo "::set-output name=exists::false"
fi
