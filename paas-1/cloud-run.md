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

Nach dem Erstellen des Services sollte die Anwendung über das Internet erreichbar sein.

Mehr zu Google Cloud Run unter: https://cloud.google.com/run/docs/quickstarts/build-and-deploy

Leider ist der Zugriff von der fully managed version von Cloud Run auf den Cloud Memorystore noch nicht möglich (Stand 31.05.2019).

Mehr dazu unter: https://cloud.google.com/run/docs/using-gcp-services

## Bonus: 3. Pricing

Finde heraus, wie viel es pro Monat kostet, die Bid App in dieser Art zu betreiben.

Die Preisberechnung basierd auf folgenden Angaben:

- Pro Tag wird die Webseite 400'000 mal aufgerufen
- Pro Tag werden 10'000 Gebote abgegeben
