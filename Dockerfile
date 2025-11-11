FROM python:3.12-alpine

LABEL version="1.0.0"
LABEL repository="https://github.com/the-events-calendar/action-s3-utility"
LABEL maintainer="The Events Calendar <support@theeventscalendar.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.42.70'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ADD commands /commands
ENTRYPOINT ["/entrypoint.sh"]
