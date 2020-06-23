# Google Cloud SQL

Das Management möchte eine History aller Gebote haben, um Auswertungen zu machen.
Darum hat sich das Bid App Team entschieden, die Daten neu in einer Relationalen Datenbank zu speicheren.
Dazu soll Google Cloud SQL verwendet werden: https://cloud.google.com/sql

## 1. Datenbank erstellen

Erstelle eine neue hochverfügbare Datenbank. Dazu musst du folgende Befehele in der Google Cloud Shell ausführen:

```sh
gcloud services enable sql-component.googleapis.com

# Datenbank erstellen
# High Availabilty - Automatic failover to another zone within your selected region. Recommended for production instances. Increases cost.
gcloud sql instances create bid-db --tier=db-n1-standard-2 --region=europe-west1 --availability-type=REGIONAL --enable-bin-log

# Datenbank Root Account
gcloud sql users set-password root --host=% --instance=bid-db --password=root123

# Bid Datenbank erstellen
gcloud sql databases create bidapp --instance=bid-db
gcloud sql users create bidapp --instance=bid-db --password=password123
```

## 2. Datenbank Schema importieren

Importiere das Datenbank Schema in die Datenbank `bidapp`.

```sh
# Download dump.sql
wget https://raw.githubusercontent.com/mat1/cascld-kubernetes/master/sampleapp/dump.sql

# Verbindung zur Datenbank herstellen
gcloud sql connect bid-db --user=root

# Importiere dump.sql in der mysql Konsole
use bidapp;

source dump.sql;

show tables;
```

`show tables` sollte folgendes Resultat zurück geben:

```sh
+------------------+
| Tables_in_bidapp |
+------------------+
| bid              |
+------------------+
```

## 3. Bid App mit Datenbank verbinden

Erstellt eine neuer Cloud Run Service basierend auf dem Bid App Dockerimage z.B. `bid-app-db` welcher die Daten in der zuvor erstellten MySQL Datenbank speichert.
Verwendet für das Erstellen des Cloud Run Services die Google Cloud Shell.

Damit die Bid App eine Verbindung zur Datenbank herstellen kann, müssen folgende zwei Umgebungsvariabeln gesetzt sein: `MYSQL_UNIX_SOCKET` und `MYSQL_PASSWORD`.

Die Dokumentation wie von Cloud Run auf Cloud SQL zugegriffen werden kann findet ihr hier: https://cloud.google.com/sql/docs/mysql/connect-run

Eine Dokumentation der Cloud Run Befehle findet ihr hier: https://cloud.google.com/sdk/gcloud/reference/run

## 4. Bonus: Test Failover

Im Schritt 2 haben wir eine hochverfügabe Datenbank erstellt. Nun wollen wir dies auch Testen, um sicher zugehen das unsere Anwendung mit einem Failover umgehen kann.

1. Prüfen ob die Datenbank Instanz hochverfügbar ist

```sh
gcloud sql instances describe bid-db
```

Sollte `availabilityType`=`REGIONAL` zurückgeben.

2. Failover manuell auslösen 

```sh
gcloud sql instances failover bid-db
```

3. Prüfe ob die Bid App während dem Failover erreichbar ist z.B. mit Apache Bench oder mit dem Browser

Mehr zum Thema Failover und HA-Setup unter: https://cloud.google.com/sql/docs/mysql/high-availability

## 5. Bonus: Backup & Restore

In dieser Übung geht es darum, ein Backup der Datenbank zu erstellen und wieder herzustellen.

1. Merke dir das aktuelle Höchstgebot in der Bid App

2. Erstelle ein Backup der Datenbank in der Google Cloud Console (UI)

3. Erhöhe das Höchstgebot

4. Stelle die Datenbank vom zuvor erstellen Backup wieder her

Nun sollte das Höchstgebot wieder den Wert von Schritt 1 haben.


