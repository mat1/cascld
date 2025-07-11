# Bid App mit Terraform

Architecture

## 0. Neues Projekt

Erstelle ein neues Google Cloud Projekt.

## 1. Push Image und Services aktivieren

Damit eine Anwendung über Google Cloud Run deployt werden kann, muss das Dockerimage in der Google Cloud Registry vorhanden sein.

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
docker pull ghcr.io/dsi-engineering-ag/kubernetes-hands-on-sampleapp:latest

docker tag ghcr.io/dsi-engineering-ag/kubernetes-hands-on-sampleapp:latest gcr.io/PROJECTID/bid-app

# Pushe das Image in die Google Container Registry
docker push gcr.io/PROJECTID/bid-app
```

Aktiviere weitere benötigte Services. Dieser Schritt wäre auch über Terraform möglich.

```sh
gcloud services enable run.googleapis.com cloudbuild.googleapis.com
```

## 2. Cloud Run



## 3. Database

## 4. Connect Cloud Run to Database

