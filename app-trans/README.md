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



