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