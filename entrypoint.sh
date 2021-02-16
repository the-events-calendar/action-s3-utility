#!/bin/sh

if [ -z "$S3_BUCKET" ]; then
  echo "S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$S3_ACCESS_KEY_ID" ]; then
  echo "S3_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$S3_SECRET_ACCESS_KEY" ]; then
  echo "S3_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

if [ -z "$S3_REGION" ]; then
  echo "S3_REGION is not set. Quitting."
  exit 1
fi

if [ -z "$S3_ENDPOINT" ]; then
  echo "S3_ENDPOINT is not set. Quitting."
  exit 1
fi

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

echo "Checking for file existence at s3://${AWS_S3_BUCKET}/${FILE} at the ${S3_ENDPOINT}"

# Verify file existence.
aws s3api head-object --bucket ${AWS_S3_BUCKET} --key ${FILE}

# XXX: we are just checking the error code, but should check the result for a 404, and raise error in other cases
if [ $? == 0 ]
then
  echo "::set-output name=exists::true"
else
  echo "::set-output name=exists::false"
fi
