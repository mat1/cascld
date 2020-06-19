## Google Cloud SQL

https://cloud.google.com/sql/docs/mysql/connect-run?hl=de

```sh
gcloud services enable sql-component.googleapis.com

## Availabilty
gcloud sql instances create bid-db --tier=db-n1-standard-2 --region=europe-west1 --availability-type=REGIONAL --enable-bin-log

# DB Root Account
gcloud sql users set-password root --host=% --instance=bid-db --password=root123

# Create Bid Database
gcloud sql databases create bidapp --instance=bid-db
gcloud sql users create bidapp --instance=bid-db --password=password123

# Import dump.sql

gcloud sql import sql bid-db gs://[BUCKET_NAME]/[IMPORT_FILE_NAME] --database=bidapp
```

## Connect to Database

https://cloud.google.com/sql/docs/mysql/connect-admin-ip

```sh
# Download dump.sql
wget https://raw.githubusercontent.com/mat1/cascld-kubernetes/master/sampleapp/dump.sql

gcloud sql connect bid-db --user=root

# import dump.sql
use bidapp;

source dump.sql;

show tables;
```

## Connect to Database From Cloud Run

https://cloud.google.com/sdk/gcloud/reference/run/deploy

```sh
gcloud run deploy bid-app-db-2 \
  --image gcr.io/cascld2020/bid-app \
  --region=europe-west1 \
  --platform=managed \
  --add-cloudsql-instances cascld2020:europe-west1:bid-db \
  --set-env-vars MYSQL_UNIX_SOCKET="/cloudsql/cascld2020:europe-west1:bid-db",MYSQL_PASSWORD="password123" \
  --allow-unauthenticated
```

docker pull matthiasbrun/cascld
docker tag matthiasbrun/cascld gcr.io/cascld2020/bid-app
docker push gcr.io/cascld2020/bid-app
