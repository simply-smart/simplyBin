@echo off
setlocal EnableDelayedExpansion

:: Sprawdzanie głównych argumentów
if "%~1"=="" goto usage

:: Rozdzielenie komendy od opcji
for /f "tokens=1,* delims=:" %%a in ("%1") do (
    set COMMAND=%%a
    set OPTION=%%b
)

:: Wywołanie odpowiedniej funkcji w zależności od argumentu
if /i "!COMMAND!"=="--new-xampp-vhost" (
        call :new_xampp_vhost
    goto :eof
)

if /i "!COMMAND!"=="--win-host" (
    call :win_host
    goto :eof
)

if /i "!COMMAND!"=="--win-host" (
    call :win_host
    goto :eof
)

if /i "!COMMAND!"=="--xampp-vhost" (
    call :xampp_vhost
    goto :eof
)

:usage
echo Usage: %~nx0 command

:: Header display
echo.
echo ========================================================================
echo 		   simplySMART Configuration Tool	 	
echo 			   Version: 1.0          	 	
echo      Marcin Ulezalka (marcin.ulezalka@simplysmart.pl)	
echo ========================================================================
echo.
echo Available commands:
echo.
echo   --new-vhost        - Creates a new virtual host.
echo   --new-vhost:root   - Creates a new virtual host with root directory.
echo   --new-xampp-vhost  - Backup and Create vhost file in Xampp.
echo   --win-host         - Display Windows host file.
echo   --xampp-vhost      - Display Xampp Virtual hosts file.
echo.
goto :eof

:new_vhost
    echo Creating a new virtual host...
    set /p HOSTNAME="Enter the host name (e.g., project.localhost): "
    set /p PROJECTPATH="Enter the full path to the project directory (e.g., C:\xampp\htdocs\): "
    set /p PROJECTPORT="Enter the port (e.g., 80): "

    :: Prepare the hosts file entry
    set NEWHOSTS=127.0.0.1 %HOSTNAME%

    :: Prepare the VirtualHost configuration
    set NEWVHOST=^<VirtualHost *:%PROJECTPORT%^>^
    echo ServerName %HOSTNAME%^
    echo DocumentRoot "%PROJECTPATH%"^
    echo ^<Directory "%PROJECTPATH%"^>^
    echo AllowOverride All^
    echo Require all granted^
    echo ^</Directory^>^
    echo ^</VirtualHost^>

    :: Confirm changes
    echo Do you want to save these changes? (y/n):
    set /p CONFIRM=""

    :: Save changes upon confirmation
    if /i "!CONFIRM!"=="y" (
        echo Adding entry to the hosts file...
        echo %NEWHOSTS% >> C:\Windows\System32\drivers\etc\hosts

        echo Clearing DNS cache...
        ipconfig /flushdns
        nbtstat -R

        echo Adding VirtualHost configuration...
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

        echo Changes saved.
    ) else (
        echo Changes were not saved.
    )
    goto :eof

:new_vhost_root
    echo Creating a virtual host with root directory...
    set /p HOSTNAME="Enter the host name (e.g., project.localhost): "
    set PROJECTPATH=%CD%
    set /p PROJECTPORT="Enter the port (e.g., 80): "

    :: Prepare the hosts file entry
    set NEWHOSTS=127.0.0.1 %HOSTNAME%

    :: Prepare the VirtualHost configuration
    set NEWVHOST=^<VirtualHost *:%PROJECTPORT%^>^
    echo ServerName %HOSTNAME%^
    echo DocumentRoot "%PROJECTPATH%"^
    echo ^<Directory "%PROJECTPATH%"^>^
    echo AllowOverride All^
    echo Require all granted^
    echo ^</Directory^>^
    echo ^</VirtualHost^>

    :: Confirm changes
    echo Do you want to save these changes? (y/n):
    set /p CONFIRM=""

    :: Save changes upon confirmation
    if /i "!CONFIRM!"=="y" (
        echo Adding entry to the hosts file...
        echo %NEWHOSTS% >> C:\Windows\System32\drivers\etc\hosts

        echo Clearing DNS cache...
        ipconfig /flushdns
        nbtstat -R

        echo Adding VirtualHost configuration...
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

        echo Changes saved.
    ) else (
        echo Changes were not saved.
    )
    goto :eof

:win_host
    :: Read and show WIN:hosts
    echo.
    echo ============================================ start-hosts 
    echo.
    more C:\Windows\System32\drivers\etc\hosts
    echo.
    echo ============================================ end-hosts 
    echo. 
    goto :eof

:new_xampp_vhost  
    :: Define the path to the Apache configuration file and its backup
    set "VHOSTS_FILE=C:\xampp\apache\conf\extra\httpd-vhosts.conf"
    set "BACKUP_FILE=C:\xampp\apache\conf\extra\httpd-vhosts.conf_backup"

    :: Check if the configuration file exists
    if not exist "%VHOSTS_FILE%" (
      echo Configuration file does not exist: %VHOSTS_FILE%
      goto :eof
    )

    :: Copy the configuration file to a new file (backup)
    echo Creating backup...
    copy /Y "%VHOSTS_FILE%" "%BACKUP_FILE%" >nul
    if errorlevel 1 (
      echo An error occurred while creating the backup of the file.
      goto :eof
    ) else (
      echo Backup was successfully created: %BACKUP_FILE%
    )

    :: Clear the original configuration file
    echo Clearing configuration file...
    break > "%VHOSTS_FILE%"
    if errorlevel 1 (
      echo An error occurred while clearing the configuration file.
      goto :eof
    ) else (
      echo Configuration file has been cleared.
    )
    goto :eof

:xampp_vhost
    :: Read and show XAMPP:vhosts
    echo.
    echo ============================================ start-vhosts
    echo.
    more C:\xampp\apache\conf\extra\httpd-vhosts.conf
    echo.
    echo ============================================ end-vhosts
    echo.   
    goto :eof

:endlocal
pause
