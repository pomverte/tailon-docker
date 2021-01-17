FROM python:3.7-alpine

VOLUME /logs
EXPOSE 80

RUN apk update \
  && apk --no-cache add grep gawk curl \
  && pip install tailon==1.4.2

RUN rm -f /usr/bin/awk /bin/grep

# Tailon will return a 401 Unauthorized
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -o -I -L -s -w "%{http_code}" http://localhost || exit 1

CMD tailon -c /etc/tailon/tailon-config.yml
