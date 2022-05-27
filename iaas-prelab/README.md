# Prelab

Im CAS Cloud gibt es Unterschiede im Vorwissen im Bereich Cloud / IT.

Ziele des Prelabs:

* Notebook für Labs vorbereitet
* Umgang mit dem Terminal lernen
* Verwendung von häufigen Befehlen wie: ls, cat, mv, cp, curl

## Windows

1. Windows Terminal installieren: https://docs.microsoft.com/en-us/windows/terminal/

2. WSL installieren: https://docs.microsoft.com/en-us/windows/wsl/install

PowerShell als Administrator

```sh
wsl --install
```

> Alternative: Linux VM oder Git Bash https://gitforwindows.org/ 

## Hilfe zu Befehlen

tldr (Too long; didn't read) bitte gute und kurze Erklärungen zu den meisten Linux Befehlen.

* tldr: https://tldr.ostera.io/
* tldr installieren https://github.com/tldr-pages/tldr

**Alternative**

```sh
# Show short manual for command
cat --help
```

```sh
# Show manual for command
man cat
```

## Übung 1 - Umgang mit Dateien

Ziel der Übung ist, dass ihr alles per Kommandozeile ausführt.

> Befehle: mkdir, touch, echo, cat, cp, vim

1. Erstelle per Kommandozeile einen Ordner `casprelab`

2. Erstelle im Ordner `casprelab` die Datei `index.html`

3. Kopiere den Inhalt unten in die Datei `index.html`

```html

```

4. Gebe den Inhalt der Datei `index.html` auf der Konsole aus

5. Kopiere `index.html` nach `contact.html`

6. Ersetze im `contact.html` den Text "Welcome CAS Cloud" mit deinem Namen

## Übung 2 - Software installieren

1. Installiere node

2. Intalliere npm

3. Installiere https://github.com/http-party/http-server

```sh
sudo npm install http-server -g
```

## Übung 3 - Webserver & curl

