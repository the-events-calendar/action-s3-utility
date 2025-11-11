#!/bin/sh

set -e

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

echo "Checking for file existence at s3://${S3_BUCKET}/${FILE} at the ${S3_ENDPOINT}"

the_command="aws ${S3_PROFILE} ${ENDPOINT_APPEND} s3api head-object --bucket ${S3_BUCKET} --key ${FILE} $*"

echo $the_command

# Verify file existence.
sh -c "$the_command"

# XXX: we are just checking the error code, but should check the result for a 404, and raise error in other cases
if [ $? == 0 ]
then
  echo "File exists."
  echo "exists=true" >> $GITHUB_OUTPUT
else
  echo "File does not exist."
  echo "exists=false" >> $GITHUB_OUTPUT
fi
