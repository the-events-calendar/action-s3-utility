#!/bin/sh

set -e

if [ -z "$COMMAND" ]; then
  echo "You must specify a command to execute. Quitting."
  exit 1
fi

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

S3_PROFILE="--profile action-s3-utility"

# Create a dedicated profile for this action
aws configure --profile action-s3-utility <<-EOF > /dev/null 2>&1
${S3_ACCESS_KEY_ID}
${S3_SECRET_ACCESS_KEY}
${S3_REGION}
text
EOF

if [[ "$COMMAND" == "ls" ]]; then
  . /commands/ls.sh
elif [[ "$COMMAND" == "sync" ]]; then
  . /commands/sync.sh
elif [[ "$COMMAND" == "exists" ]]; then
  . /commands/exists.sh
elif [[ "$COMMAND" == "rm" ]]; then
  . /commands/rm.sh
fi

# Clear out credentials after we're done.
aws configure --profile action-s3-utility <<-EOF > /dev/null 2>&1
null
null
null
text
EOF
