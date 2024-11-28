# Diretrizes Gerais

[reading grademe](https://tuto.grademe.fr/inception/#mariadb)


## Docker Compose
```yaml
version: '3.7' # version of docker-compose

services: # services that will be created
  
  mariadb: # service name
    container_name: mariadb
    networks: # networks that will be connected
      - inception # network name
    build: # build context
      context: requirements/mariadb # path to Dockerfile
      dockerfile: Dockerfile # Dockerfile name
      env_file: # environment file
        - .env # path to environment file
    volumes: # volumes that will be mounted
      - mariadb:/var/lib/mysql # volume name and path
    restart: unless-stopped # restart policy for the container
    expose: # ports that will be exposed
      - 3306 # port number
    environment: # environment variables
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE_NAME: ${MYSQL_DATABASE_NAME}
      MYSQL_USER_NAME: ${MYSQL_USER_NAME}
      MYSQL_USER_PASSWORD: ${MYSQL_USER_PASSWORD}
      
  nginx: # service name
    container_name: nginx
    volumes: # volumes that will be mounted
      - wordpress:/var/www/html/wordpress # volume name and path
    networks: # networks that will be connected
      - inception # network name
    depends_on: # services that will be depended on
      - wordpress # service name
    build: # build context
    context: requirements/nginx # path to Dockerfile
    dockerfile: Dockerfile # Dockerfile name
    env_file: # environment file
      - .env # path to environment file
    ports: # ports that will be exposed
      - "443:443" # port number
    restart: on-failure # restart policy for the container

  wordpress: # service name
    container_name: wordpress
    env_file: # environment file
      - .env # path to environment file
    volumes: # volumes that will be mounted
      - wordpress:/var/www/html/wordpress # volume name and path
    networks: # networks that will be connected
      - inception # network name
    build: # build context
    context: requirements/wordpress # path to Dockerfile
    dockerfile: Dockerfile # Dockerfile name
    depends_on: # services that will be depended on
      - mariadb # service name
    restart: on-failure # restart policy for the container
    expose: # ports that will be exposed
      - 9000 # port number
    environment: # environment variables
      MYSQL_HOST:  ${MYSQL_HOST}
      WP_DATABASE_NAME: ${WP_DATABASE_NAME}
      WP_DATABASE_USR: ${WP_DATABASE_USR}
      WP_DATABASE_PWD: ${WP_DATABASE_PWD}
      WP_URL: ${WP_URL}
      WP_TITLE: ${WP_TITLE}
      WP_ADMIN_USR: ${WP_ADMIN_USR}
      WP_ADMIN_PWD: ${WP_ADMIN_PWD}
      WP_ADMIN_EMAIL: ${WP_ADMIN_EMAIL}
      WP_USER_USR: ${WP_USER_USR}
      WP_USER_PWD: ${WP_USER_PWD}
      WP_USER_EMAIL: ${WP_USER_EMAIL}

volumes: # volumes that will be created
  wordpress: # volume name
    driver: local # volume driver
    driver_opts: # volume driver options
      type: none # volume driver type
      device: '/home/faaraujo/data/wordpress' # volume driver device
  mariadb: # volume name
    driver: local # volume driver
    driver_opts: # volume driver options
      type: 'none' # volume driver type
      device: '/home/faaraujo/data/mariadb' # volume driver device
      o: bind # volume driver options

networks: # networks that will be created
  inception: # network name
    driver: bridge # network driver
```

## Wordpress

[...]

## MariaDB

[...]

## Docker

[...]


### [Alpine linux](https://docs.alpinelinux.org/user-handbook/0.1a/Working/apk.html)

[...]

### nginx

[...]

### openssl

[...]