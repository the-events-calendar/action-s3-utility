FROM python:3.7-alpine

LABEL version="1.0.0"
LABEL repository="https://github.com/the-events-calendar/action-s3-exists"
LABEL maintainer="The Events Calendar <support@theeventscalendar.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.18.69'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
