FROM python:3.7-alpine

VOLUME /logs
EXPOSE 80

RUN apk update \
  && apk add grep gawk \
  && apk add curl \
  && pip install tailon

RUN rm -f /usr/bin/awk /bin/grep \
  && rm -rf /var/cache/apk/*

# Tailon will return a 401 Unauthorized
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -o -I -L -s -w "%{http_code}" http://localhost || exit 1

CMD tailon -c /etc/tailon/tailon-config.yml
