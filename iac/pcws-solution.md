# PC-WS - Google Cloud Solution

## 1. Create Docker Image

0. More Infos [app-trans](./../app-trans/README.md)
1. Download Artifacts: https://github.com/SamuelBucheliZ/bfh-pcws

```sh
docker build . -t pcws

# Start PCWS with mock profile
docker run -p 8080:8080 -e SPRING_PROFILES_ACTIVE=mock pcws
```

2. Create New Google Cloud Project and Enable Conatiner Registry

```sh
gcloud config set project cas-pcws

gcloud services enable artifactregistry.googleapis.com

gcloud auth login

gcloud auth configure-docker

docker tag pcws gcr.io/cas-pcws/pcws
docker push gcr.io/cas-pcws/pcws
```

3. Enable services

```sh
gcloud services enable run.googleapis.com cloudbuild.googleapis.com sql-component.googleapis.com sqladmin.googleapis.com servicenetworking.googleapis.com compute.googleapis.com cloudscheduler.googleapis.com
```

## 2. Import Databse Schema

```sh
gcloud sql connect pcws-db --database=pcws-db --user=pcws --quiet

# SQL script copy & paste and execute

# Test
SELECT * FROM pcws_codes;
```

## 3. Create Docker Image for Transfer Logs

```sh
# in app-trans/transfer/
docker build . -t transfer-logs
docker tag transfer-logs gcr.io/cas-pcws/transfer-logs
docker push gcr.io/cas-pcws/transfer-logs
```

## Terraform Solution 

See folder pcws.