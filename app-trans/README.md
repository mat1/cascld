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

```sh
gcloud auth login

gcloud auth configure-docker

gcloud config set project cascld2022

docker tag pcws gcr.io/cascld2022/pcws
docker push gcr.io/cascld2022/pcws
```

## 3. Cloud Run with Mock Profile

```sh
gcloud run deploy pcws \
  --image gcr.io/cascld2022/pcws \
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
gcloud sql connect pcws-new-db --user=postgres --quiet

# SQL script copy & paste and execute

# Test
SELECT * FROM pcws_codes;
```

## Connect to DB - Public IP

```sh
# jdbc:postgresql://34.65.42.61:5432/postgres

gcloud run deploy pcws \
  --image gcr.io/cascld2022/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --set-env-vars SPRING_PROFILES_ACTIVE=real,USE_DATALOG_SERVICE_MOCK=true,PCWS_DATASOURCE_JDBC_URL=jdbc:postgresql://34.65.42.61:5432/postgres,PCWS_DATASOURCE_USERNAME=postgres,PCWS_DATASOURCE_PASSWORD=root1234 \
  --allow-unauthenticated
```

## Connect to DB over VPC

```sh
# Create VPC connector
gcloud services enable vpcaccess.googleapis.com

gcloud compute networks vpc-access connectors create bid-app-connector --region europe-west6 --range 10.8.0.0/28

# Connect to private ip
gcloud run deploy pcws \
  --image gcr.io/cascld2022/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --vpc-connector=projects/cascld2022/locations/europe-west6/connectors/bid-app-connector \
  --set-env-vars SPRING_PROFILES_ACTIVE=real,USE_DATALOG_SERVICE_MOCK=true,PCWS_DATASOURCE_JDBC_URL=jdbc:postgresql://10.67.176.2:5432/postgres,PCWS_DATASOURCE_USERNAME=postgres,PCWS_DATASOURCE_PASSWORD=root1234 \
  --allow-unauthenticated
```

## Write to Cloud Storage or File System

Code Anpassen damit direkt auf Cloud Storage geschrieben wird. --> Hat Auswirkung auf Shell Script

https://cloud.google.com/storage/docs/reference/libraries

https://cloud.google.com/run/docs/using-gcp-services#connecting_to_services_in_code

Fuse - Mount Cloud Storage (Similar to S3)

https://cloud.google.com/run/docs/tutorials/network-filesystems-fuse


Mount Network Filesystem (Einfacher) - Filestore

https://cloud.google.com/run/docs/tutorials/network-filesystems-filestore

## Ohne Filesystem z.B. Pub / Sub und Google Function
