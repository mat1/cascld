# App Trans

## Setup Local

```sh
docker build . -t pcws

# Start PCWS with mock profile
docker run -p 8080:8080 -e SPRING_PROFILES_ACTIVE=mock pcws
```

## Push Image to Google Container Registry

```sh
gcloud auth login

gcloud auth configure-docker

gcloud config set project cascld2022

docker tag pcws gcr.io/cascld2022/pcws
docker push gcr.io/cascld2022/pcws
```

## Start cloud run with mock profile

```sh
gcloud run deploy pcws \
  --image gcr.io/cascld2022/pcws \
  --region=europe-west6 \
  --platform=managed \
  --min-instances=1 \
  --set-env-vars SPRING_PROFILES_ACTIVE="mock" \
  --allow-unauthenticated
```

## Setup database

Im UI

1. PostgresSQL DB mit Version 10 erstellen.
2. Password `root1234`
3. Private IP (Damit der Code nicht angepasst werden muss). Alternative Public IP und DB ist vom Internet aus erreichbar :)
4. Ligthwight
5. 10 GB Storage

```sh
gcloud sql connect pcws-new-db --user=postgres --quiet

# SQL script copy & paste and execute

# Test
SELECT * FROM pcws_codes;
```

6. Allow Connection from everywhere `0.0.0.0/0`

## Connect to DB

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

## Connecto to DB over VPC

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


