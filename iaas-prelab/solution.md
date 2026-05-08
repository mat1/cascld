# Lösung

Beispiel-Loesung. Es gibt viele weitere Moeglichkeiten, diese Uebungen zu loesen.

## Übung 1 - Umgang mit Dateien

1. Erstelle per Kommandozeile einen Ordner `casprelab`

```sh
mkdir casprelab
```

2. Erstelle im Ordner `casprelab` die Datei `index.html`

```sh
cd casprelab
touch index.html
```

3. Kopiere den Inhalt unten in die Datei `index.html`

```sh
vim index.html
```

4. Gib den Inhalt der Datei `index.html` auf der Konsole aus

```sh
cat index.html
```

5. Kopiere `index.html` nach `contact.html`

```sh
cp index.html contact.html
```

6. Ersetze im `contact.html` den Text "Welcome CAS Cloud" mit deinem Namen

```sh
vim contact.html
```

7. Liste die Dateien im Ordner `casprelab` auf. Eine Zeile pro Datei. Erwartetes Resultat:

```sh
ls -l

total 8
-rw-r--r-- 1 user user 73 May 27 13:05 contact.html
-rw-r--r-- 1 user user 77 May 27 13:03 index.html
```

8. **Dateien finden**: Verwende den Befehl `find` im `casprelab` Ordner, um alle HTML-Dateien zu listen.

```sh
find . -type f -name "*.html"
```

9. **Inhalte durchsuchen**: Benutze `grep`, um in allen HTML-Dateien nach dem Wort "Welcome" zu suchen.

```sh
grep -R "Welcome" *.html
```

## Übung 2 - Software installieren

1. Installiere webfs

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

1. Starte den http-server im Ordner `casprelab`

```sh
cd casprelab
webfsd -F -p 8080 -d -f index.html -r .
```

2. Öffne die Webseite im Browser http://localhost:8080/

3. Mache ein HTTP Request mit `curl` auf `localhost:8080`. Erwartetes Resultat:

```sh
curl localhost:8080

<!DOCTYPE html>
<html>
<body>
    <h1>Welcome CAS Cloud</h1>
</body>
</html>
```

4. Mache ein HTTP Request mit `curl` auf `contact.html`. Erwartetes Resultat:

```sh
curl localhost:8080/contact.html

<!DOCTYPE html>
<html>
<body>
    <h1>Matthias Brun</h1>
</body>
</html>
```

## Übung 4 - Pipes & Redirects

1. Erstelle im Ordner `casprelab` eine Datei `logs.txt` mit folgendem Inhalt:

```sh
cat > logs.txt <<'EOF'
INFO Start
ERROR Database
INFO Retry
WARN Timeout
ERROR Database
INFO Done
EOF
```

2. Zaehle alle Zeilen mit `ERROR` in `logs.txt` und gib nur die Anzahl aus.

```sh
grep "ERROR" logs.txt | wc -l
```

3. Schreibe alle `INFO` Zeilen in eine neue Datei `info.txt`.

```sh
grep "^INFO" logs.txt > info.txt
```

4. Haenge eine weitere Zeile `INFO Finished` an `info.txt` an.

```sh
echo "INFO Finished" >> info.txt
```

## Übung 5 - Prozesse & Ports

1. Starte `webfsd` wie in Uebung 3 auf Port `8080`.

```sh
webfsd -F -p 8080 -d -f index.html -r .
```

2. Finde den Prozess, der auf Port `8080` lauscht.

```sh
lsof -i :8080
```

3. Stoppe genau diesen Prozess mit `kill`.

```sh
kill <PID>
```

4. Pruefe mit `lsof -i :8080`, dass auf Port `8080` kein Prozess mehr laeuft.

```sh
lsof -i :8080
```

Wenn kein Output kommt, ist der Port frei.

5. Bonus: Was ist der Unterschied zwischen `kill` und `kill -9`?

- `kill <PID>` sendet standardmaessig `SIGTERM` (Prozess kann sauber aufraeumen).
- `kill -9 <PID>` sendet `SIGKILL` (sofortiges Beenden, ohne Aufraeumen).

## Übung 6 - Fehler suchen (Troubleshooting)

1. `webfsd: command not found`

```sh
# Linux
sudo apt install webfs

# Mac
brew install webfs
```

2. `Address already in use` beim Start auf Port `8080`

```sh
lsof -i :8080
kill <PID>
```

Alternative: anderen Port waehlen.

```sh
webfsd -F -p 8081 -d -f index.html -r .
```

3. `curl: (7) Failed to connect to localhost port 8080`

```sh
# Pruefen, ob Server laeuft
lsof -i :8080

# Falls nicht: starten
webfsd -F -p 8080 -d -f index.html -r .
```

4. Du bist im falschen Ordner und `index.html` wird nicht gefunden

```sh
pwd
ls -l
cd ~/casprelab
ls -l index.html
```

5. Bonus: Verwende `man webfsd` oder `tldr`, um zwei Flags aus der Webserver-Konfiguration zu erklaeren

Beispiel:

- `-p 8080`: setzt den Port auf `8080`
- `-f index.html`: liefert `index.html` als Standarddatei aus

## Weitere Ressourcen & Übungen

- Online Challenge um spielerisch den Umgang mit der Shell zu lernen https://cmdchallenge.com/
- Linux Command Cheat Sheet https://www.guru99.com/linux-commands-cheat-sheet.html
