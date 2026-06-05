# Google Cloud SQL - Solution

## 3. Bid App mit Datenbank verbinden

Wenn über das UI muss google cloud sql admin noch aktiviert werden.

```sh
gcloud services enable sqladmin.googleapis.com
```

Dem Service Account Zugriff auf Cloud SQL geben:

```sh
gcloud projects add-iam-policy-binding cascld-498506 \
  --member="serviceAccount:639540411093-compute@developer.gserviceaccount.com" \
  --role="roles/cloudsql.client"
```

```sh
gcloud run deploy bid-app-db \
  --image gcr.io/cascld-498506/bid-app \
  --region=europe-west6 \
  --platform=managed \
  --add-cloudsql-instances cascld-498506:europe-west6:bid-db \
  --set-env-vars MYSQL_UNIX_SOCKET="/cloudsql/cascld-498506:europe-west6:bid-db",MYSQL_PASSWORD="password123" \
  --allow-unauthenticated
```

## 4. Bonus: Test Failover

Bid App ist kurz nicht erreichbar. Failover in den Logs sichtbar.

HA: https://cloud.google.com/sql/docs/mysql/high-availability
Replication: https://cloud.google.com/sql/docs/mysql/replication

z.B. Seperate Read Only Datenbank für Reporting.
In der Regel asychnrone Updates bei MySQL (kurzes Delay).

## Connection Handling

Aktuell ist das Datenbank Connection Handling nicht ideal.
Idealerweise würde man einen Connection Pool verwenden: https://cloud.google.com/sql/docs/mysql/manage-connections. 
Dazu müsste aber die Bid App angepasst werden.
