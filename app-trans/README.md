# Application Transformation

https://github.com/SamuelBucheliZ/bfh-apptrans-exercise

https://github.com/SamuelBucheliZ/bfh-pcws

## 1. Local Setup

```sh
docker build . -t pcws

# Start PCWS with mock profile
docker run -p 8080:8080 -e SPRING_PROFILES_ACTIVE=mock pcws
```

Test open http://localhost:8080/swagger-ui/index.html

## 2. Push Image to Google Container Registry

Alternative in der Google Cloud Shell Dockerimage bauen.

```sh
gcloud auth login

gcloud auth configure-docker

gcloud config set project apptrans2023

docker tag pcws gcr.io/apptrans2023/pcws
docker push gcr.io/apptrans2023/pcws
```

## 3. Cloud Run with Mock Profile

```sh
gcloud run deploy pcws-mock \
  --image gcr.io/apptrans2023/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --set-env-vars SPRING_PROFILES_ACTIVE="mock" \
  --allow-unauthenticated
```

## 4. Setup Database

Im UI

1. PostgresSQL DB mit Version 10 erstellen.
2. Password `root1234`
3. Private IP (damit der Code nicht angepasst werden muss). Alternative Public IP und DB Zugriff vom Internet zulassen.
4. Lightweight
5. 10 GB Storage
6. Allow Connection from everywhere `0.0.0.0/0` oder BFH IP

```sh
gcloud services enable sql-component.googleapis.com

gcloud sql connect pcws-db --user=postgres --quiet

# SQL script copy & paste and execute

# Test
SELECT * FROM pcws_codes;
```

## Connect to DB - Public IP (prefer private IP)

Enable `Connect to a VPC for outbound traffic`

```sh
# jdbc:postgresql://34.65.42.61:5432/postgres

gcloud run deploy pcws \
  --image gcr.io/apptrans2023/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --set-env-vars SPRING_PROFILES_ACTIVE=real,USE_DATALOG_SERVICE_MOCK=true,PCWS_DATASOURCE_JDBC_URL=jdbc:postgresql://34.65.42.61:5432/postgres,PCWS_DATASOURCE_USERNAME=postgres,PCWS_DATASOURCE_PASSWORD=root1234 \
  --allow-unauthenticated
```

## Connect to DB over VPC (Ohne VPC Connector möglich)

```sh
# Create VPC connector
gcloud services enable vpcaccess.googleapis.com

gcloud compute networks vpc-access connectors create pcws-connector --region europe-west6 --range 10.8.0.0/28

# Connect to private ip
gcloud run deploy pcws \
  --image gcr.io/apptrans2023/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --vpc-connector=projects/apptrans2023/locations/europe-west6/connectors/pcws-connector \
  --set-env-vars SPRING_PROFILES_ACTIVE=real,USE_DATALOG_SERVICE_MOCK=true,PCWS_DATASOURCE_JDBC_URL=jdbc:postgresql://10.121.224.2:5432/postgres,PCWS_DATASOURCE_USERNAME=postgres,PCWS_DATASOURCE_PASSWORD=root1234 \
  --allow-unauthenticated
```

## Write to Cloud Storage or File System


Code Anpassen damit direkt auf Cloud Storage geschrieben wird. --> Hat Auswirkung auf Shell Script

https://cloud.google.com/storage/docs/reference/libraries

https://cloud.google.com/run/docs/using-gcp-services#connecting_to_services_in_code

Fuse - Mount Cloud Storage (Similar to S3)

### Write to Cloud Storage Bucket (Kann jetzt relativ einfach gemacht werden)

![cloud-run-volume](./cloud-run-mount-volume.png)

https://cloud.google.com/run/docs/configuring/services/cloud-storage-volume-mounts#gcloud_1

### Filestore

https://cloud.google.com/run/docs/tutorials/network-filesystems-filestore

```sh
gcloud config set filestore/zone europe-west6-a

gcloud filestore instances create pcws-store \
    --tier=STANDARD \
    --file-share=name=pcws,capacity=1TiB \
    --network=name="default"


export FILESTORE_IP_ADDRESS=$(gcloud filestore instances describe pcws-store --format "value(networks.ipAddresses[0])")

gcloud iam service-accounts create fs-identity

gcloud run deploy filesystem-app --source . \
    --vpc-connector CONNECTOR_NAME \
    --execution-environment gen2 \
    --allow-unauthenticated \
    --service-account fs-identity \
    --update-env-vars FILESTORE_IP_ADDRESS=$FILESTORE_IP_ADDRESS,FILE_SHARE_NAME=FILE_SHARE_NAME
```

## Ohne Filesystem z.B. Pub / Sub und Google Function
