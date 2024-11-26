## 1. Socket de comunicação do MySQL
- O diretório `/run/mysqld` tem um papel importante na operação do MariaDB/MySQL:

1. Função Principal:
- Armazena o socket de comunicação do MySQL
- Permite conexões locais entre aplicações e o banco de dados
- Facilita comunicação rápida e segura entre processos

2. Conteúdo Típico:
- `mysqld.sock`: Socket Unix para conexões locais
- Arquivos de lock e pid do processo

3. Criação e Permissões:
```bash
# Criar diretório
mkdir -p /run/mysqld

# Definir permissões corretas
chown -R mysql:mysql /run/mysqld

# Definir permissões de acesso
chmod 777 /run/mysqld
```

4. No Script bash/Configuração:
```bash
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chmod 777 /run/mysqld
fi
```

5. Na Configuração do MariaDB:
```ini
[mysqld]
socket = /run/mysqld/mysqld.sock
```

6. Importância no Projeto Inception:
- Permite comunicação entre containers
- Essencial para configurações com WordPress ou outros serviços

## 2. Configuração Inicial do Banco de Dados:
```bash
# Criar diretório de dados (se não existir)
mkdir -p /var/lib/mysql

# Definir permissões corretas
chown -R mysql:mysql /var/lib/mysql

# Inicializar banco de dados
mysql_install_db --basedir=/usr --user=mysql --datadir=/var/lib/mysql > /dev/null
```
- `--basedir=/usr`: Especifica o diretório base onde os binários do MariaDB estão instalados. Isso pode ser necessário se os binários não estiverem no caminho padrão.
- `--datadir=/var/lib/mysql`: Define o diretório onde os dados do banco de dados serão armazenados.
- `--user=mysql`: Especifica que o usuário `mysql` deve ser o proprietário dos arquivos e diretórios criados.
- `> /dev/null`: Redireciona a saída padrão para null, efetivamente suprimindo qualquer saída do comando.

Quando você instala o MariaDB no Alpine Linux usando o gerenciador de pacotes `apk`, os binários geralmente são instalados nos diretórios padrão. No entanto, é sempre uma boa prática verificar onde os binários foram instalados para garantir que você está usando os caminhos corretos.

### Verificando a Localização dos Binários

Você pode verificar a localização dos binários do MariaDB usando o comando `which` ou `whereis`:

```sh
which mysql_install_db
```

ou

```sh
whereis mysql_install_db
```

Se o comando retornar um caminho como `/usr/bin/mysql_install_db`, isso significa que os binários estão no diretório padrão e você não precisa usar a flag `--basedir`.

## 3. Configurar Usuário e Banco de Dados:
- Criar arquivo temporário para executar comandos SQL para:
  1. Criar Banco de Dados
  2. Criar Usuário
  3. Conceder Privilégios

```bash
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
```

```bash
tmp_file=$(mktemp)
```
Neste exemplo:
- `mktemp` cria um arquivo temporário e retorna o caminho completo para esse arquivo.
- `$(mktemp)` executa o comando `mktemp` e substitui a expressão pelo caminho do arquivo temporário.
- `tmp_file=$(mktemp)` armazena o caminho do arquivo temporário na variável `tmp_file`.

```bash
# Arquivo temporário
cat << EOF > $tmp_file
USE mysql; # Acessar banco de dados mysql
FLUSH PRIVILEGES; # Atualizar privilégios
DELETE FROM mysql.user WHERE user=''; # Remover usuário sem nome
DROP DATABASE test; # Remover banco de dados de teste
DELETE FROM mysql.db WHERE Db='test'; # Remover banco de dados de teste
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1'); # Remover usuário root que não estao conectados localmente
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; # Alterar senha do usuário root
CREATE DATABASE $MYSQL_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci; # Criar banco de dados para a aplicação
CREATE USER '$MYSQL_USER_NAME'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; # Criar usuário para a aplicação
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER_NAME'@'%'; # Conceder privilégios ao usuário da aplicação
FLUSH PRIVILEGES; # Atualizar privilégios
EOF
```

```bash
	# Executar comandos SQL
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tmp_file
	rm -f $tmp_file
```
### Contexto do Comando:
- `/usr/bin/mysqld`: O binário do servidor MySQL/MariaDB.
- `--user=mysql`: Executa o servidor MySQL/MariaDB como o usuário `mysql`.
- `--bootstrap`: Inicia o servidor MySQL/MariaDB em modo bootstrap, que é usado para inicializar o banco de dados.
- `--verbose=0`: Define o nível de verbosidade para 0, minimizando a saída do comando.
- `< $tmp_file`: Redireciona a entrada do comando a partir do arquivo temporário `$tmp_file`.

### Resumo:
A flag `--verbose=0` é usada para minimizar a saída do comando, exibindo o mínimo de informações possível durante a execução do servidor MySQL/MariaDB em modo bootstrap. Isso pode ser útil para evitar a poluição do log com mensagens desnecessárias durante a inicialização do banco de dados.

*[Fix for error: access denied](https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw)*



6. Configurar Inicialização Automática:
```bash
# Habilitar início automático
rc-update add mariadb default

# Iniciar o serviço
rc-service mariadb start
```

7. Verificações de Segurança:
```bash
# Verificar status
rc-service mariadb status

# Verificar conexões
netstat -tuln | grep 3306

# Ver logs
tail -f /var/log/mysql/error.log
```

8. Configurações Adicionais de Segurança:
```bash
# Configurar firewall (se estiver usando)
apk add iptables
iptables -A INPUT -p tcp --dport 3306 -j DROP
# Depois configure para permitir apenas IPs necessários
```

9. Backup:
```bash
# Backup simples
mysqldump -u root -p --all-databases > /backup/full-backup.sql

# Backup de um banco específico
mysqldump -u root -p inception_db > /backup/inception_db_backup.sql
```

Pontos de Atenção:
- Sempre use senhas fortes
- Limite o acesso remoto
- Mantenha o sistema atualizado
- Configure backups regulares
- Use criptografia para conexões sensíveis

Troubleshooting Comum:
- Se o serviço não iniciar, verifique os logs
- Garanta que as permissões de diretório estejam corretas
- Verifique se todas as dependências estão instaladas

Comandos Úteis:
```bash
# Parar serviço
rc-service mariadb stop

# Reiniciar
rc-service mariadb restart

# Ver status
rc-service mariadb status
```

3. Configuração de Segurança:
```bash
# Iniciar o serviço temporariamente
/etc/init.d/mariadb start

# Executar script de segurança interativo
mysql_secure_installation
```

Durante o `mysql_secure_installation`, você será solicitado a:
- Definir senha para root
- Remover usuários anônimos
- Desabilitar login remoto do root
- Remover banco de dados de teste
- Recarregar tabela de privilégios

4. Configuração Personalizada:
Edite o arquivo de configuração:
```bash
# Abrir arquivo de configuração
vi /etc/my.cnf.d/mariadb-server.cnf
```

Configurações recomendadas:
```ini
[mysqld]
# Configurações básicas
user = mysql
port = 3306
datadir = /var/lib/mysql
socket = /var/run/mysqld/mysqld.sock

# Configurações de segurança
bind-address = 0.0.0.0  # Cuidado com isso em produção!

# Limites de conexão
max_connections = 100
max_user_connections = 50

# Configurações de performance
innodb_buffer_pool_size = 128M
query_cache_size = 16M

# Logs
log-error = /var/log/mysql/error.log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
```
