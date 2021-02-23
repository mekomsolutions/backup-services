FROM alpine

RUN apk add bash postgresql-client
RUN mkdir -p /opt/backup
COPY entrypoint.sh /opt/entrypoint.sh
COPY wait-for-it.sh /opt/wait-for-it.sh
ENTRYPOINT ["/opt/entrypoint.sh"]