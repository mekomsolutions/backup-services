FROM alpine
RUN apk add zip mysql-client bash
RUN mkdir -p /opt/backup
COPY entrypoint.sh /opt/entrypoint.sh
COPY wait-for-it.sh /opt/wait-for-it.sh
ENTRYPOINT ["/opt/entrypoint.sh"]