# PC-WS Cloud Deployment mit Terraform

Das Management von **Pakett Blitz** war vom Cloud-Proof-of-Concept begeistert. Nun soll jedoch die Infrastrukturkonfiguration automatisiert werden.  
Daher wurde entschieden, die Migration der Anwendung **PC-WS** mittels **Terraform** in die Cloud durchzuführen.

## Ziel

Das Ziel dieser Übung ist es, die Anwendung [PC-WS](https://github.com/SamuelBucheliZ/bfh-pcws) mithilfe von **Terraform** in eine Cloud-Umgebung zu migrieren (z.B. in die Google Cloud).  
Als Referenz dient das folgende Architekturdiagramm:

**Architekturdiagramm einfügen**

> Hinweis: Ihr müsst nicht exakt dieser Architektur folgen. Auch ein anderer Cloud-Provider als **Google Cloud** ist möglich.  
> Das Management vertraut auf eure Cloud-Expertise.

## Vorgehen

Diese Übung ist **nicht** als Schritt-für-Schritt-Anleitung gedacht. Ziel ist es, euer Wissen aus den vorherigen Übungen anzuwenden.  
Zur groben Orientierung könnt ihr euch an folgendem Ablauf orientieren:

1. **PC-WS ohne Datenbank deployen**
2. **Datenbank einrichten** und das bestehende Schema importieren
3. **PC-WS mit der Datenbank verbinden**
4. **Cloud Storage / Bucket** für `PCWS_DATALOG_DIRECTORY` einrichten
5. **PC-WS mit dem Storage verbinden**
6. **Transfer-Job einrichten**, um Daten aus dem Bucket zu verarbeiten

> Wie bei der App Trans Übung kanst du den [PC-WS Viewer](https://samuelbucheliz.github.io/bfh-pcws-viewer/) verwenden fürs Testing.

## Bonus: Alerting & Monitoring

Das Management möchte die **Verfügbarkeit von PC-WS** überwachen, um das **SLA** einzuhalten.  
Zusätzlich sollen **Benachrichtigungen per E-Mail** versendet werden, wenn der Service nicht verfügbar ist.
