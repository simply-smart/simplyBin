[https://github.com/simply-smart/simplyBin/blob/main/assets/icon_package/128x128.png?raw=true]

# simplyBin
`simplySMART Configuration Tool`

## Overview
The simplySMART Configuration Tool is a Batch script for managing virtual hosts on a local development environment. It provides a convenient way to configure virtual hosts for XAMPP and Windows, including options to display, add, and backup virtual host configurations.

## Version
1.0

## System Requirements
- Windows Operating System
- XAMPP (if managing XAMPP virtual hosts)

## Usage
To use the script, run it from the command line with a specific command argument. The syntax is as follows:

## Install


## Commands
- `--new-vhost`  
  Creates a new virtual host.

- `--new-vhost:root`  
  Creates a new virtual host with the project directory set to the current directory.

- `--new-xampp-vhost`  
  Backs up and creates a new virtual host file in XAMPP.

- `--win-host`  
  Displays the Windows host file.

- `--xampp-vhost`  
  Displays the XAMPP virtual hosts file.

## Detailed Function Descriptions

### --new-vhost
Prompts for a hostname, project path, and port, and configures a new virtual host entry in the Windows and XAMPP configuration files.

### --new-vhost:root
Similar to `--new-vhost`, but automatically sets the project directory to the current directory.

### --new-xampp-vhost
Creates a backup of the existing XAMPP vhost file and clears its content for new configuration.

### --win-host
Displays the contents of the Windows hosts file.

### --xampp-vhost
Displays the configured virtual hosts in the XAMPP environment.


## Author
Marcin Ulezalka  
