# Google Cloud SQL - Solution

## 3. Bid App mit Datenbank verbinden

```sh
gcloud run deploy bid-app-db-2 \
  --image gcr.io/cascld2020/bid-app \
  --region=europe-west1 \
  --platform=managed \
  --add-cloudsql-instances cascld2020:europe-west1:bid-db \
  --set-env-vars MYSQL_UNIX_SOCKET="/cloudsql/cascld2020:europe-west1:bid-db",MYSQL_PASSWORD="password123" \
  --allow-unauthenticated
```

## Connection Handling

Aktuell ist das Datenbank Connection Handling nicht ideal.
Idealerweise würde man einen Connection Pool verwenden: https://cloud.google.com/sql/docs/mysql/manage-connections. Dazu müsste aber die Bid App angepasst werden.
