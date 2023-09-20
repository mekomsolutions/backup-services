FROM debian:stable

RUN apt-get update && \
    apt-get install -y python3 python3-pip cron && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli --break-system-packages


ENV AWS_ACCESS_KEY_ID=,AWS_SECRET_ACCESS_KEY=,AWS_DEFAULT_REGION=,S3_PATH=,CRON_SCHEDULE="0 1 * * *",PARAMS=
VOLUME ["/data"]

ADD *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/run.sh"]
