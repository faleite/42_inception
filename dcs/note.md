# Diretrizes Gerais

[reading grademe](https://tuto.grademe.fr/inception/#mariadb)

### Docker
- Build a container Docker:
  - `docker build path/to/Dockerfile` *or*
  - `docker build .` *-> Dockerfile in the current directory*
  - `docker build -t container_name .` *-> you can give a name to the container*
- Show the available images on your machine:
  - `docker image ls`
- Initialize a container:
  - `docker run -it container-name` *-> `-it`: open the terminal of the container*
- Show the running containers:
  - `docker ps`
  - `docker ps -a` *-> show all containers including the stopped ones*
  
#### Dockerfile
1. **FROM**: Imagem base
 - I used the [alpine](https://alpinelinux.org/releases/)

### [Alpine linux](https://docs.alpinelinux.org/user-handbook/0.1a/Working/apk.html)
- **`apk`**: Alpine Package Keeper
  - `apk add package_name` *-> install a package*
  - `apk del package_name` *-> remove a package*
  - `apk search package_name` *-> search for a package*
  - `apk update` *-> update the package list*
  - `apk upgrade` *-> upgrade the installed packages*

### Others useful commands
- `mkdir -p /path/to/directory` *-> create a directory and its parent directories if they don't exist*

### nginx
- `nginx -t` *-> test the configuration file*

### openssl
***open source cryptography library that is widely used to create and manage SSL/TLS certificates***
- O comando `openssl req` é usado para criar e processar pedidos de assinatura de certificado (Certificate Signing Requests - CSR). 
  - Ele pode ser usado para gerar um novo certificado autoassinado ou para criar um CSR que pode ser enviado a uma autoridade certificadora (CA) para obter um certificado assinado.

Contexto do Dockerfile:

```dockerfile
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"
```

Explicação das flags usadas:
- `-x509`: Gera um certificado autoassinado em vez de um CSR.
- `-nodes`: Não criptografa a chave privada.
- `-out`: Especifica o arquivo de saída para o certificado.
- `-keyout`: Especifica o arquivo de saída para a chave privada.
- `-subj`: Define os campos do assunto do certificado (país, estado, localidade, organização, unidade organizacional, nome comum, UID).
  - `UID`: *-> User ID*