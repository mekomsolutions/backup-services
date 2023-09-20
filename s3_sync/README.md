
Docker image that periodically backups files to Amazon S3 using s3cmd sync and cron.

## Usage

docker run -d [OPTIONS] mekomsolutions/s3_sync

## Parameters:

-e ACCESS_KEY=<AWS_KEY>: Your AWS key.

-e SECRET_KEY=<AWS_SECRET>: Your AWS secret.

-e S3_PATH=s3://<BUCKET_NAME>/<PATH>/: S3 Bucket name and path. Should end with trailing slash.

-v /path/to/backup:/data:ro: mount target local folder to container's data folder. Content of this folder will be synced with S3 bucket.

### Optional parameters:

-e PARAMS="--dry-run": parameters to pass to the sync command (full list here).

-e DATA_PATH=/data/: container's data folder. Default is /data/. Should end with trailing slash.

-e 'CRON_SCHEDULE=0 1 * * *': specifies when cron job starts (details). Default is 0 1 * * * (runs every day at 1:00 am).

no-cron: run container once and exit (no cron scheduling).

### Examples:

Run upload to S3 everyday at 12:00pm:

    ```bash
    docker run -d \
    -e AWS_ACCESS_KEY_ID=secretkey \
    -e AWS_SECRET_ACCESS_KEY=secretAccessKey \
    -e S3_PATH=s3://my-bucket/backup/ \
    -e 'CRON_SCHEDULE=0 12 * * *' \
    -v /home/user/data:/data:rw \
    mekomsolutions/s3_sync
    ```

Run once then delete the container:

    ```bash
    docker run --rm \
    -e AWS_ACCESS_KEY_ID=secretkey \
    -e AWS_SECRET_ACCESS_KEY=secretAccessKey \
    -e S3_PATH=s3://my-bucket/backup/ \
    -v /home/user/data:/data:ro \
    mekomsolutions/s3_sync no-cron
    ```
Run once to get from S3 then delete the container:
    ```bash
    docker run --rm \
    -e AWS_ACCESS_KEY_ID=secretkey \
    -e AWS_SECRET_ACCESS_KEY=secretAccessKey \
    -e S3_PATH=s3://my-bucket/backup/ \
    -v /home/user/data:/data:rw \
    mekomsolutions/s3_sync get
    ```

Docker compose
    ```
    version: '3'
    services:
    upload-backup:
        image: mekomsolutions/s3_sync
        environment:
        - AWS_ACCESS_KEY_ID=secretkey
        - AWS_SECRET_ACCESS_KEY=secretAccessKey
        - S3_PATH=s3://ghc-ows-backup/
        - CRON_SCHEDULE=*/5 * * * *
        volumes:
        - ./data/upload:/data:rw
        restart: always
    download-backup:
        image: mekomsolutions/s3_sync
        command:
        - cron-get
        environment:
        - AWS_ACCESS_KEY_ID=secretkey
        - AWS_SECRET_ACCESS_KEY=secretAccessKey
        - S3_PATH=s3://ghc-ows-backup/
        - CRON_SCHEDULE=*/5 * * * *
        volumes:
        - ./data/download:/data:rw
        restart: always
    ```
### S3 Bucket Policies

From a security perspective it is often preferable to create a dedicated IAM user that only has access to the specific bucket it needs f. The following IAM policies can then be attached to that user to give the minimum amount of required access.

Write Policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                ""s3:*"",
            ],
            "Resource": [
                "arn:aws:s3:::my-bucket",
                "arn:aws:s3:::my-bucket/*"
            ]
        }
    ]
}
```

Read Policy

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject*"
            ],
           "Resource": [
                "arn:aws:s3:::my-bucket",
                "arn:aws:s3:::my-bucket/*"
            ]
        }
    ]
}
```
