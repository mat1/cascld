# Prelab

Ziele der IaaS Lab Vorbereitung:

* Die Kursteilnehmer sind für das IaaS Lab vorbereitet.
* Die Kursteilnehmer koennen Dateien per Kommandozeile erstellen, kopieren, bearbeiten und durchsuchen.
* Die Kursteilnehmer koennen einen lokalen Webserver starten, testen und wieder beenden.

## Windows

1. Windows Terminal installieren: https://docs.microsoft.com/en-us/windows/terminal/

2. WSL installieren: https://docs.microsoft.com/en-us/windows/wsl/install

PowerShell als Administrator

```sh
wsl --install
```

> Alternative: Linux VM oder Git Bash https://gitforwindows.org/ 

## Mac

Mac User koennen fuer die Uebungen das Mac Terminal verwenden.

## Hilfe zu Unix Befehlen

```sh
# Show short manual for command (does not work for Mac)
cat --help
```

```sh
# Show manual for command
man cat
```

**Alternative**

tldr (Too long; didn't read) bietet gute und kurze Erklärungen zu den meisten Linux Befehlen.

* tldr https://tldr.inbrowser.app/
* tldr installieren https://github.com/tldr-pages/tldr

## Übung 1 - Umgang mit Dateien

Ziel der Übung ist, dass ihr alles per Kommandozeile ausführt.

> Befehle: mkdir, touch, ls, cat, cp, cd, vim, find, grep

1. Erstelle per Kommandozeile einen Ordner `casprelab`

2. Erstelle im Ordner `casprelab` die Datei `index.html`

3. Kopiere den Inhalt unten in die Datei `index.html` z.B. mit `vim`

```html
<!DOCTYPE html>
<html>
<body>
    <h1>Welcome CAS Cloud</h1>
</body>
</html>
```

4. Gib den Inhalt der Datei `index.html` auf der Konsole aus

5. Kopiere `index.html` nach `contact.html`

6. Ersetze im `contact.html` den Text "Welcome CAS Cloud" mit deinem Namen z.B. mit `vim`

7. Liste die Dateien im Ordner `casprelab` mit `ls -l` auf. Erwartetes Resultat (kann je nach OS leicht abweichen):

```sh
total 8
-rw-r--r-- 1 user user 73 May 27 13:05 contact.html
-rw-r--r-- 1 user user 77 May 27 13:03 index.html
```

8. Dateien finden: Verwende den Befehl `find` im `casprelab` Ordner, um alle HTML-Dateien zu listen. Erwartetes Resultat:

```sh
./contact.html
./index.html
```

9. Inhalte durchsuchen: Benutze `grep`, um in allen HTML-Dateien nach dem Wort "Welcome" zu suchen. Erwartetes Resultat:

```sh
index.html:    <h1>Welcome CAS Cloud</h1>
```

## Übung 2 - Software installieren

> Befehle: apt oder brew

1. Installiere webfs (einfacher Webserver): https://linux.bytesex.org/misc/webfs.html

Linux (WSL/Ubuntu):

```sh
sudo apt update
sudo apt install webfs
```

Mac (Homebrew):

```sh
brew install webfs
```

## Übung 3 - Webserver & curl

> Befehle: webfsd, curl

1. Starte webfs im Ordner `casprelab`

```sh
webfsd -F -p 8080 -d -f index.html -r .
```

Bonus: Schaue in der webfs Dokumentation nach, was die einzelnen Flags (-F, -p) für einen Effekt haben.

2. Öffne die Webseite im Browser http://localhost:8080/

3. Mache ein HTTP Request mit `curl` auf `localhost:8080`. Erwartetes Resultat:

```sh
<!DOCTYPE html>
<html>
<body>
    <h1>Welcome CAS Cloud</h1>
</body>
</html>
```

4. Mache ein HTTP Request mit `curl` auf `contact.html`. Erwartetes Resultat:

```sh
<!DOCTYPE html>
<html>
<body>
    <h1>Matthias Brun</h1>
</body>
</html>
```

## Übung 4 - Pipes & Redirects

> Befehle: cat, grep, wc, >, >>

1. Erstelle im Ordner `casprelab` eine Datei `logs.txt` mit folgendem Inhalt:

```text
INFO Start
ERROR Database
INFO Retry
WARN Timeout
ERROR Database
INFO Done
```

2. Zaehle alle Zeilen mit `ERROR` in `logs.txt` und gib nur die Anzahl aus.

3. Schreibe alle `INFO` Zeilen in eine neue Datei `info.txt`.

4. Haenge eine weitere Zeile `INFO Finished` an `info.txt` an.

## Übung 5 - Prozesse & Ports

> Befehle: ps, lsof, kill

1. Starte `webfsd` wie in Uebung 3 auf Port `8080`.

2. Finde den Prozess, der auf Port `8080` lauscht.

3. Stoppe genau diesen Prozess mit `kill`.

4. Pruefe mit `lsof -i :8080`, dass auf Port `8080` kein Prozess mehr laeuft.

5. Bonus: Was ist der Unterschied zwischen `kill` und `kill -9`?

## Optional: Übung 6 - Fehler suchen (Troubleshooting)

Bearbeite die folgenden Situationen und notiere jeweils den Loesungsbefehl.

1. `webfsd: command not found`

2. `Address already in use` beim Start auf Port `8080`

3. `curl: (7) Failed to connect to localhost port 8080`

4. Du bist im falschen Ordner und `index.html` wird nicht gefunden

5. Bonus: Verwende `man webfsd` oder `tldr`, um zwei Flags aus der Webserver-Konfiguration zu erklaeren

## Weitere Ressourcen & Übungen

- Online Challenge um spielerisch den Umgang mit der Shell zu lernen https://cmdchallenge.com/
- Linux Command Cheat Sheet https://www.guru99.com/linux-commands-cheat-sheet.html
