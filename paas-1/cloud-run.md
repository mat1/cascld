# Google Cloud Run

Das Management möchte das Vendor-Lockin reduzieren und wider auf einen Container Ansatz setzen.
Dabei möchten Sie die automatische Skalierung beibehalten. Das Bid Team entscheidet sich für Google Cloud Run.

Bei dieser Übung wir die Bid App als Docker Container mittels Google Cloud Run deployt.

## 1. Dockerimage in die Cloud Registry Pushen

Damit eine Anwendung über Google Cloud Run deployt werden kann, muss das Dockerimage in der Google Cloud Registry vorhanden sein.
Wie man ein Dockerimage in die Google Cloud Registry pusht ist hier beschrieben https://cloud.google.com/container-registry/docs/pushing-and-pulling

1. Google Cloud Shell aktivieren
2. Docker Authentification konfigurieren

```sh
gcloud auth configure-docker
```

3. Dockerimage in die Cloud Registry pushen

```sh
# Aktiviere die Container Registry
gcloud services enable containerregistry.googleapis.com

# Hole das Image vom Dockerhub
docker pull fluescher/cascld

docker tag fluescher/cascld gcr.io/PROJECTID/bid-app

# Pushe das Image in die Google Container Registry
docker push gcr.io/PROJECTID/bid-app
```

## 2. Google Cloud Run Service erstellen

1. Suche nach `Cloud Run`
2. Create service
3. Container image url `gcr.io/PROJECTID/bid-app`
4. Service name `bid-app`
5. Allow unauthenticated invocations aktivieren
6. Region `europe-west6`

Nach dem Erstellen des Services sollte die Anwendung über das Internet erreichbar sein.

Mehr zu Google Cloud Run unter: https://cloud.google.com/run

## 3. Redis Memorystore

In der Google Cloud Shell

```sh
# Aktiviere Redis API
gcloud services enable redis.googleapis.com

# Erstelle ein Redis Cluster (selbe Region wie der Cloud Run Container)
gcloud redis instances create bid-app-redis --region europe-west6
```

## 4. Serverless VPC Access erstellen

Damit Cloud Run auf den Memorystore zugreiffen kann, benötigen wir Serverless VPC Access (https://cloud.google.com/vpc/docs/configure-serverless-vpc-access?hl=en).

```sh
# Aktiviere VPC Access
gcloud services enable vpcaccess.googleapis.com

gcloud compute networks vpc-access connectors create bid-app-connector --region europe-west6 --range 10.8.0.0/28
```

Anschliessend kann die Bid App angepasst werden, dass dieser Connector verwendet wird. Zudem muss die Umgebungsvariable `REDIS_HOST` gesetzt werden.

## Bonus: 5. Lasttest

Generie Last und beobachte, wie sich die Anwendung verhält.
Ihr könnt z.B. mit ApacheBench Last generieren: https://httpd.apache.org/docs/2.4/programs/ab.html

```sh
ab -n 30000 -c 300 http://YOURWEBSITE.COM/
```

## Bonus: 6. Pricing

Finde heraus, wie viel es pro Monat kostet, die Bid App in dieser Art zu betreiben (ohne Redis Cluster).

Die Preisberechnung basierd auf folgenden Angaben:

- Pro Tag wird die Webseite 400'000 mal aufgerufen
- Pro Tag werden 10'000 Gebote abgegeben

## Unofficial FAQ for Google Cloud Run

https://github.com/ahmetb/cloud-run-faq
