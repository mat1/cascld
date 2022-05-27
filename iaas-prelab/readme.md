# Prelab

Ziele der IaaS Lab Vorbereitung:

* Die Kursteilnehmer sind für das IaaS Lab vorbereitet
* Die Kursteilnehmer können mit wichtigen Unix Befehlen & Tools umgehen (ls, cat, mv, cp, mkdir, vim)

## Windows

1. Windows Terminal installieren: https://docs.microsoft.com/en-us/windows/terminal/

2. WSL installieren: https://docs.microsoft.com/en-us/windows/wsl/install

PowerShell als Administrator

```sh
wsl --install
```

> Alternative: Linux VM oder Git Bash https://gitforwindows.org/ 

## Hilfe zu Unix Befehlen

```sh
# Show short manual for command
cat --help
```

```sh
# Show manual for command
man cat
```

**Alternative**

tldr (Too long; didn't read) bietet gute und kurze Erklärungen zu den meisten Linux Befehlen.

* tldr https://tldr.ostera.io/
* tldr installieren https://github.com/tldr-pages/tldr

## Übung 1 - Umgang mit Dateien

Ziel der Übung ist, dass ihr alles per Kommandozeile ausführt.

> Befehle: mkdir, touch, ls, cat, cp, cd, vim

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

4. Gebe den Inhalt der Datei `index.html` auf der Konsole aus

5. Kopiere `index.html` nach `contact.html`

6. Ersetze im `contact.html` den Text "Welcome CAS Cloud" mit deinem Namen z.B. mit `vim`

7. Liste die Dateien im Ordner `casprelab` auf. Eine Zeile pro Datei. Erwartetes Resultat:

```sh
total 8
-rw-r--r-- 1 user user 73 May 27 13:05 contact.html
-rw-r--r-- 1 user user 77 May 27 13:03 index.html
```

## Übung 2 - Software installieren

1. Installiere node

2. Installiere npm

3. Installiere https://github.com/http-party/http-server

```sh
sudo npm install http-server -g
```

## Übung 3 - Webserver & curl

1. Starte den http-server im Ordner `casprelab`

2. Öffne die Webseite im Browser

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

## Weitere Ressourcen & Übungen

- Online Challenge um spielerisch den Umgang mit der Shell zu lernen https://cmdchallenge.com/
- Linux Command Cheat Sheet https://www.guru99.com/linux-commands-cheat-sheet.html
