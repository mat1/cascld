# Make Bid App Secure

Bei dieser Übung gibt es keine Reihenfolge. Ihr könnt die Themen angehen, die euch am meisten interessieren.

## Secure Your Infrastructure - Security Groups

Versucht mit Hilfe von Security Groups die Kommunikation zwischen den einzelnen Komponenten soweit wie möglich einzuschränken.

## Protect Data at Transport - HTTPS

Die Kommunikation zwischen den Benutzern und der Bid App ist unverschlüsselt über HTTP. Ziel dieser Übung ist es, dass die Webseite über HTTPS ausgeliefert wird.
Ihr könnt dazu das Wildcard Zertifikat `*.cascld.com` verwenden. Anschliessend könnt ihr das Zertifikat im Application Load Balancer eintragen. Dazu müsst ihr einen neuen Listener erstellen.

Nun könnt ihr eure Anwendung über https:// aufrufen. Im Browser solltet ihr eine Warnung sehen, dass das Zertifikat ungültig ist. Warum ist dies so?

## Audit & Überwachung

AWS Cloud Trail zeichnet auf, wer wann was geändert hat in der AWS Cloud.

Versucht mit AWS Cloud Trail folgende Fragen zu beantworten:

- Wer hat zuletzt eine neue EC2 Instanz gestartet?

- Wer hat zuletzt eine Security Group angepasst? Was wurde geändert?`AuthorizeSecurityGroupIngress`, `AuthorizeSecurityGroupEngress`..

> Ihr müsst kein neuen Trail erstellen, sondern im Cloud Trail Menü "Event history" auswählen.

## Bonus: Protect Data at Rest & at Transport - Redis

Für diese Übung müsst ihr die Bonus Übung "Redis" vom IaaS Lab gelöst haben. Aktuell werden die Daten zwischen der Bid App und dem Redis Cluster unverschlüsselt übertragen. Zudem werden die Daten im Redis Cluster unverschlüsselt auf die Disk gespeichert.

Erstellt einen neuen Redis Cluster und aktiviert `Encryption at-rest`, `Encryption in-transit` und `Redis AUTH`.

Definiert ein Redis AUTH Token: z.B. `MY-REDIS-AUTH-TOKEN`

Konfiguriert die Bid App, damit die Verbindung zum neuen Redis Cluster hergestellt wird. Ihr könnt das AUTH Token als Umgebungsvariable übergeben:

```sh
docker run -p 8080:80 -e REDIS_HOST=master.bid-redis-secure.f76nxh.euc1.cache.amazonaws.com -e REDIS_AUTH_TOKEN=MY-REDIS-AUTH-TOKEN ghcr.io/dsi-engineering-ag/kubernetes-hands-on-sampleapp:latest
```