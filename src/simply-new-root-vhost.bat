@echo off
setlocal EnableDelayedExpansion

:: Pobieranie parametrów od użytkownika
set /p HOSTNAME="Wprowadz nazwe hosta (np. projekt.localhost): "
set PROJECTPATH=%CD%
set /p PROJECTPORT="Podaj port (np. 80): "

:: Przygotowanie wpisu do pliku hosts
set NEWHOSTS=127.0.0.1 %HOSTNAME%

:: Przygotowanie konfiguracji VirtualHost
set NEWVHOST=^<VirtualHost *:%PROJECTPORT%^>^
echo ServerName %HOSTNAME%^
echo DocumentRoot "%PROJECTPATH%"^
echo ^<Directory "%PROJECTPATH%"^>^
echo AllowOverride All^
echo Require all granted^
echo ^</Directory^>^
echo ^</VirtualHost^>

:: Pytanie o zapisanie zmian
echo Czy zapisac te zmiany? (y/n):
set /p CONFIRM=""

:: Zapis zmian po potwierdzeniu
if /i "%CONFIRM%"=="y" (
    echo Dodawanie wpisu do pliku hosts...
    echo %NEWHOSTS% >> C:\Windows\System32\drivers\etc\hosts

    echo Czyszczenie cache DNS...
    ipconfig /flushdns
    nbtstat -R

    echo Dodawanie konfiguracji VirtualHost...
    (
        echo ^<VirtualHost *:%PROJECTPORT%^>
        echo     ServerName %HOSTNAME%
        echo     DocumentRoot "%PROJECTPATH%"
        echo     ^<Directory "%PROJECTPATH%"^>
        echo         AllowOverride All
        echo         Require all granted
        echo     ^</Directory^>
        echo ^</VirtualHost^>
    ) >> C:\xampp\apache\conf\extra\httpd-vhosts.conf

    echo Zmiany zapisane.
) else (
    echo Zmiany nie zostaly zapisane.
)

pause
endlocal
