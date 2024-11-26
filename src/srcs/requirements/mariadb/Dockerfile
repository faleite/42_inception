FROM alpine:3.19.4

# Install MariaDB
RUN apk update && apk upgrade && \
	apk add --no-cache mariadb mariadb-client

# Copy the configuration file
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy the database initialization script
COPY tools/db_config.sh /tmp/db_config.sh

# Set the execution permissions for the script
ENTRYPOINT ["sh", "/tmp/db_config.sh"]
