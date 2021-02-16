#!/bin/sh

set -e

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

# Default to us-east-1 if AWS_REGION not set.
if [ -z "$S3_REGION" ]; then
  S3_REGION="us-east-1"
fi

# Override default AWS endpoint if user sets S3_ENDPOINT
if [ -z "$S3_ENDPOINT" ]; then
  ENDPOINT_APPEND="--endpoint-url $S3_ENDPOINT"
fi

if [ -z "$FILE" ]; then
  echo "FILE is not set. Quitting."
  exit 1
fi

# Create a dedicated profile for this action
aws configure --profile action-s3-exists <<-EOF > /dev/null 2>&1
${S3_ACCESS_KEY_ID}
${S3_SECRET_ACCESS_KEY}
${S3_REGION}
text
EOF

echo "Checking for file existence at s3://${S3_BUCKET}/${FILE} at the ${S3_ENDPOINT}"

# Verify file existence.
sh -c "aws s3api head-object --bucket ${S3_BUCKET} --key ${FILE} \
  --profile action-s3-exists \
  ${ENDPOINT_APPEND} $*"

# XXX: we are just checking the error code, but should check the result for a 404, and raise error in other cases
if [ $? == 0 ]
then
  echo "::set-output name=exists::true"
else
  echo "::set-output name=exists::false"
fi

# Clear out credentials after we're done.
aws configure --profile action-s3-exists <<-EOF > /dev/null 2>&1
null
null
null
text
EOF
