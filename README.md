```
██╗███╗   ██╗ ██████╗███████╗██████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║██║     █████╗  ██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║██║     ██╔══╝  ██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║
██║██║ ╚████║╚██████╗███████╗██║        ██║   ██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                Administering a network of machines.                                                          
```

*This project aims to broaden your knowledge of system administration by using Docker.\
You will virtualize several Docker images, creating them in your new personal virtual machine.*


 Skills | Grade |
:------:|:-----:|
[**Rigor**] [**Network & system administration**] [**Unix**]  | *Subscribed* |
<!-- **:white_check_mark: 100%** -->

## Index
* **[Mandatory part](#mandatory-part)**
  * **[Summary](#summary)**
  * **[Structure](#structure)**
* **[Tools](#tools)**
  * **[Docker](#docker)**
  * **[Alpine linux](#alpine-linux)**
  * **[openssl](#openssl)**
* **[Study resources](#study-resources)**
* **[Workflow](https://github.com/users/faleite/projects/1)**

## Mandatory part
### Summary
*This document describes a system administration exercise using Docker. The goal is to broaden students' knowledge of system administration by virtualizing multiple Docker images in a personal virtual machine. The exercise is divided into mandatory and bonus parts, with specific guidelines for each stage. The mandatory part requires setting up an infrastructure with services such as Nginx, WordPress, and MariaDB, using volumes to store the database and site files. The bonus part offers options to expand the infrastructure, including implementing a Redis cache, FTP server, and other services at the student's discretion. The document provides detailed instructions on project structure, requirements, resources, and submission and evaluation methods.*

### Structure
```bash
.
├── Makefile
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs
    ├── .env
    ├── docker-compose.yml
    └── requirements
        ├── bonus
        ├── mariadb
        │   ├── .dockerignore
        │   ├── Dockerfile
        │   └── conf
        ├── nginx
        │   ├── .dockerignore
        │   ├── Dockerfile
        │   └── conf
        ├──  wordpress
        │  ├── .dockerignore
        │  ├── Dockerfile
        │  └── conf
        └── tools
            ├── .dockerignore
            ├── Dockerfile
            └── conf
```     

- **Guidelines:**
    - [ ] Volumes: `WordPress database`, `WordPress site files`
        - [ ] Must be available in the `/home/<login>/data` folder of the host machine using **Docker**.
    - [ ] Containers to be placed:
        - [ ] `NGINX` (with TLS v1.2)
        - [ ] `WordPress` (with configured php-fpm)
        - [ ] `MARIADB` (without NGINX)
 
---
- **Work Environment:** 
    - [ ] The project must be carried out in a virtual machine.
- **Project Structure:** 
    - [ ] All configuration files must be in the `"srcs"` folder. 
    - [ ] A `Makefile` in the root directory will set up the entire application, 
    - [ ] including building the Docker images using the "docker-compose.yml" file.
    ### Infrastructure to be created:
    - **Objective:** Create a small infrastructure composed of different services, using:
        - [ ] `Docker Compose` in a `virtual machine`. 
            - [ ] Each service must run in a **dedicated container**, 
            - [ ] built from the _second-to-last stable version of_ `Alpine` or `Debian`.

    - **Services:** 
        - [ ] `NGINX` container with TLSv1.2 or TLSv1.3.
        - [ ] `WordPress` + `php-fpm` container (installed and configured) without `nginx`.
        - [ ] `MariaDB` container.
    - **Volumes:** 
        - [ ] Volume for the `WordPress database`.
        - [ ] Volume for the `WordPress site files`.
    - **Docker Network:** 
        - [ ] A Docker network must connect the containers.
    - **Restrictions:** 
        - [ ] The use of "network: host", "--link" or "links:" is prohibited.
        - [ ] Containers cannot be started with infinite loop commands.
        - [ ] The "latest" tag is prohibited.
        - [ ] Passwords should not be included in Dockerfiles.

    - **Environment variables:** should be used, preferably stored
        - [ ] in a `".env"` file 
        - [ ] and `Docker Secrets` for sensitive information.

    - **Access to Infrastructure:** 
        - [ ] The `NGINX` container must be the only entry point, through **port 443**, using the TLSv1.2 or TLSv1.3 protocol.

    - **WordPress Configuration:** 
        - [ ] The WordPress database must have two users, one of which is the administrator. 
            - [ ] The administrator's username cannot contain "admin" or "administrator".
    - **Domain:** 
        - [ ] The domain `"login.42.fr"` (replacing "login" with the student's login) must be configured to point to the local IP address.
    - **Security:** 
        -  [ ] Credentials, API keys, and passwords must be stored locally and ignored by Git for security reasons.

[↑ Index ↑](#index)

## Tools

### Docker

#### Build a container Docker:
- `docker build path/to/Dockerfile` *or*
- `docker build .` *-> Dockerfile in the current directory*
- `docker build -t container_name .` *-> you can give a name to the container*

#### Show the available images on your machine:
- `docker image ls`
- Initialize a container:
  - `docker run -it container-name` *-> `-it`: open the terminal of the container*
- Show the running containers:
  - `docker ps`
  - `docker ps -a` *-> show all containers including the stopped ones*
 
#### Stop a container:
- `docker stop container_id` *-> stop the container*
- `docker rm container_id` *-> remove the container*
- `docker rmi image_id` *-> remove the image*
- `docker rm $(docker ps -aqf status=exited)` *-> remove all the stopped containers*

#### Dockerfile
1. **FROM**: Imagem base
 - I used the [alpine](https://alpinelinux.org/releases/)

#### Others useful commands
- `mkdir -p /path/to/directory` *-> create a directory and its parent directories if they don't exist*

[↑ Index ↑](#index)

### [Alpine linux](https://docs.alpinelinux.org/user-handbook/0.1a/Working/apk.html)
- **`apk`**: Alpine Package Keeper
  - `apk add package_name` *-> install a package*
  - `apk del package_name` *-> remove a package*
  - `apk search package_name` *-> search for a package*
  - `apk update` *-> update the package list*
  - `apk upgrade` *-> upgrade the installed packages*

[↑ Index ↑](#index)

### openssl
***open source cryptography library that is widely used to create and manage SSL/TLS certificates***
- The `openssl req` command is used to create and process Certificate Signing Requests (CSRs).
    - It can be used to generate a new self-signed certificate or to create a CSR that can be sent to a Certificate Authority (CA) to obtain a signed certificate.

*Context of the Dockerfile:*

```dockerfile
# First option
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 School/OU=faaraujo/CN=faaraujo/"
# "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

# Second option
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 School/OU=faaraujo/CN=faaraujo/"
```

Explanation of the flags used:
- `-newkey rsa:4096`: Generates a new 4096-bit RSA private key.
- `-sha256`: Uses the SHA-256 hash algorithm.
- `-days 365`: Sets the certificate validity to 365 days.
- `-x509`: Generates a self-signed certificate instead of a CSR.
- `-nodes`: Does not encrypt the private key.
- `-out`: Specifies the output file for the certificate.
- `-keyout`: Specifies the output file for the private key.
- `-subj`: Sets the subject fields of the certificate:
    - `/C`: *-> Country*
    - `/ST`: *-> State*
    - `/L`: *-> Locality*
    - `/O`: *-> Organization*
    - `/OU`: *-> Organizational Unit*
    - `/CN`: *-> Common Name*
    - `/UID`: *-> User ID*

[↑ Index ↑](#index)

## Study resources
- [Inception Tutorial -> **grademe**](https://tuto.grademe.fr/inception/)
- [Docker](https://docs.docker.com/manuals/)
- [Alpine Linux](https://alpinelinux.org/releases/)
- [Nginx](https://nginx.org/en/docs/)

[↑ Index ↑](#index)