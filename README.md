# backup-services
Docker images to backup databases, files and more

### MySQL backup service

To use MySQL backup docker service set the value for the following environment variables, and add a volume to retrieve the `.sql` file.

| Environment variable | Required | Default value |
|----|----|----|
| DB_HOST | Yes | localhost |
| DB_NAME | Yes | / |
| DB_USERNAME | Yes | / |
| DB_PASSWORD | Yes | / |
| DB_PORT | No | 3306 |
| BACKUP_PATH | No | /opt/backup/ |

ex:
```
docker run --rm -e DB_NAME=openmrs -e DB_USERNAME=root -e DB_PASSWORD=password -v ~/target/:/opt/backup mekomsolutions/mysql_backup
```

### PostgreSQL backup service

To use PostgreSQL backup docker service, set the value for the following environment variables, and add a volume to retrieve the database `.dump` file.

| Environment variable | Required | Default value |
|----|----|----|
| DB_HOST | Yes | localhost |
| DB_NAME | Yes | / |
| DB_USERNAME | Yes | / |
| DB_PASSWORD | Yes | / |
| DB_PORT | No | 3306 |
| BACKUP_PATH | No | /opt/backup/ |

ex:
```
docker run --rm -e DB_NAME=odoo -e DB_USERNAME=root -e DB_PASSWORD=password -v ~/target/:/opt/backup mekomsolutions/postgres_backup
```

### Filestore backup

To use Filestore backup docker service, set the value for the following environment variable, and add volumes as shown in the example below to retrieve the backup `.zip` file.

| Environment variable | Required | Default value | Description
|----|----|----| ----|
| FILESTORE_PATH | Yes | / | Path to filestore folder
| BACKUP_PATH | No | /opt/backup/ | Path where filestore backup should be stored

ex:
```
docker run --rm -e FILESTORE_PATH=/opt/data -v ~/data:/opt/data -v ~/target:/opt/backup mekomsolutions/filestore_backup
```
