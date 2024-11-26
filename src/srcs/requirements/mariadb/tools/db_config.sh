#!/bin/sh

# 1. Socket de comunicação do MySQL
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chmod 777 /run/mysqld
fi

# 2. Configuração Inicial do Banco de Dados
# Verifica e cria o diretório de dados do MySQL
if [ ! -d "/var/lib/mysql" ]; then
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
fi

# 3. Configurar Usuário e Banco de Dados:
# Inicializar banco de dados
if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --user=mysql --datadir=/var/lib/mysql > /dev/null
	
	# Criar arquivo temporário para inicialização do banco de dados
	tmp_file=$(mktemp)
	if [ ! -f "$tmp_file" ]; then
		echo "Failed to create temporary file"
		return 1
	fi

# Defina as variáveis de ambiente
# MYSQL_DATABASE_NAME=${MYSQL_DATABASE_NAME:-wordpress}
# MYSQL_USER_NAME=${MYSQL_USER_NAME:-wp_user}
# MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-wp_password}

	# Escrever comandos SQL no arquivo temporário
	cat << EOF > $tmp_file
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE user='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE \`${MYSQL_DATABASE_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER_NAME}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER_NAME}'@'%';

FLUSH PRIVILEGES;
EOF
	# Executar comandos SQL
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tmp_file
	rm -f $tmp_file
fi

# Iniciar o serviço do MySQL
exec /usr/bin/mysqld --user=mysql --console