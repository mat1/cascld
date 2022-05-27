# Lösung

Beispiel Lösung es gibt aber viele weitere Möglichkeiten, diese Übung zu lösen.

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

4. Gebe den Inhalt der Datei `index.html` auf der Konsole aus

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

## Übung 2 - Software installieren

1. Installiere node

```sh
sudo apt install nodejs
```

2. Installiere npm

```sh
sudo apt install npm
```

3. Installiere https://github.com/http-party/http-server

```sh
npm install http-server -g
```

## Übung 3 - Webserver & curl

1. Starte den http-server im Ordner `casprelab`

```sh
cd casprelab
http-server .
```

2. Öffne die Webseite im Browser

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

## Weitere Ressourcen & Übungen

- Online Challenge um spielerisch den Umgang mit der Shell zu lernen https://cmdchallenge.com/
- Linux Command Cheat Sheet https://www.guru99.com/linux-commands-cheat-sheet.html
