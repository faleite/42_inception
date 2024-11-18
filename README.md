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

* **[Mandatory part](#mandatory-part)**
* **[Study resources](#study-resources)**

### Mandatory part
<details>
  <summary><b>Roadmap</b></summary>

## Roteiro Detalhado para o Desenvolvimento do Projeto Inception

O projeto Inception, como descrito nas fontes fornecidas, tem como objetivo principal construir uma infraestrutura web funcional utilizando Docker. Essa infraestrutura será composta por três serviços principais: NGINX, WordPress e MariaDB, cada um encapsulado em um contêiner Docker dedicado e interconectados através de uma rede Docker.

**Etapas Essenciais:**

1. **Compreensão Profunda do Docker e Docker Compose:**

    * **Docker:** Essencialmente, o Docker soluciona o problema recorrente de incompatibilidade entre diferentes ambientes de desenvolvimento e produção. Ele empacota a aplicação e suas dependências em um contêiner isolado, assegurando que o software funcione de maneira consistente em qualquer máquina que execute o Docker.

    * **Docker Compose:** Para gerenciar aplicações multi-contêineres, o Docker Compose entra em cena. Através de um arquivo YAML, define-se os serviços e como eles se comunicam entre si. A grande vantagem é a capacidade de orquestrar a inicialização, parada e interação entre os contêineres de forma eficiente.

2. **Estruturação do Projeto:**

    * Crie um diretório raiz, tipicamente chamado de `srcs`, para abrigar todo o código-fonte do projeto.

    * Dentro de `srcs`, crie os seguintes diretórios:
        * `requirements`: Este diretório conterá os subdiretórios para cada serviço: `nginx`, `wordpress` e `mariadb`.
        * `nginx`, `wordpress`, `mariadb`: Cada um desses diretórios representará um contêiner e deve conter:
            * `Dockerfile`: Define as instruções para construir a imagem do contêiner.
            * `conf`: Armazena os arquivos de configuração específicos do serviço.
            * `.dockerignore`: Lista os arquivos e diretórios a serem ignorados pelo Docker durante o build.
            * `tools`: (Opcional) Contém scripts auxiliares ou ferramentas para o desenvolvimento.

    * Crie também os seguintes arquivos na raiz do projeto:
        * `Makefile`: Define os comandos para construir e gerenciar o projeto. Deve ser usado para construir as imagens Docker através do `docker-compose.yml`.
        * `.env`: Armazena as variáveis de ambiente do projeto, como senhas, chaves de API e URLs. É crucial para manter a segurança das informações sensíveis, pois este arquivo deve ser ignorado pelo Git e nunca ser versionado.

3. **Construção Detalhada do Container NGINX:**

    * **Dockerfile (srcs/requirements/nginx/Dockerfile):**

        * Comece com a instrução `FROM` para definir a imagem base. As fontes sugerem `debian:buster` para este projeto.

        * Atualize o APT: É fundamental manter o gerenciador de pacotes atualizado para garantir a instalação das versões mais recentes dos softwares. Utilize os comandos `RUN apt update -y` e `RUN apt upgrade -y`. O argumento `-y` confirma automaticamente as instalações, evitando prompts interativos durante o build do contêiner.

        * Instale o NGINX e utilitários: `RUN apt install nginx -y`. Instale também outros utilitários que você considere úteis, como `vim` e `curl`, para facilitar a interação com o contêiner durante o desenvolvimento.

        * Configure o SSL/TLS:
            * Crie o diretório para armazenar os arquivos de certificado: `RUN mkdir -p /etc/nginx/ssl`.
            * Instale o OpenSSL: `RUN apt install openssl -y`.
            * Gere o certificado autoassinado: `RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"`. Essa linha gera o certificado e a chave privada sem solicitar informações adicionais. Substitua `login` pelo seu login real.
            * Copie o arquivo de configuração customizado do NGINX: `COPY conf/nginx.conf /etc/nginx/nginx.conf`.

        * Defina as permissões de acesso:
            * Utilize `RUN chmod 755 /var/www/html` para garantir as permissões de acesso ao diretório raiz do site.
            * Defina o proprietário do diretório raiz: `RUN chown -R www-data:www-data /var/www/html`.

        * Execute o NGINX: O comando `CMD ["nginx", "-g", "daemon off;"]` inicia o NGINX em primeiro plano, garantindo que o contêiner continue em execução.

    * **Arquivo de Configuração NGINX (srcs/requirements/nginx/conf/nginx.conf):**

        * Configure o bloco `server` para ouvir na porta 443 com SSL habilitado.

        * Defina os protocolos TLS: Utilize `ssl_protocols TLSv1.2 TLSv1.3;` para especificar as versões do TLS suportadas.

        * Configure os caminhos para o certificado e chave SSL: Utilize as diretivas `ssl_certificate` e `ssl_certificate_key` apontando para os arquivos gerados no Dockerfile.

        * Defina o diretório raiz do site: `root /var/www/wordpress;`.

        * Defina o nome do servidor: Substitua `localhost` pelo seu nome de domínio, como `login.42.fr`.

        * Configure a página de índice: Utilize a diretiva `index` para especificar os arquivos de índice, como `index index.php index.html index.htm;`.

        * Configure o tratamento de erros 404: Utilize um bloco `location /` com `try_files $uri $uri/ =404;` para redirecionar requisições inválidas para uma página de erro 404.

        * Configure o proxy reverso para o WordPress: Utilize um bloco `location ~ \.php$` para passar as requisições PHP para o contêiner WordPress na porta 9000.

4. **Construção Detalhada do Container MariaDB:**

    * **Dockerfile (srcs/requirements/mariadb/Dockerfile):**

        * Utilize `FROM debian:buster` como imagem base.

        * Atualize o APT:  `RUN apt update -y` e `RUN apt upgrade -y`.

        * Instale o MariaDB: `RUN apt-get install mariadb-server -y`.

        * Copie o arquivo de configuração customizado: `COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf`.

        * Execute um script de inicialização: Utilize `COPY conf/setup.sh /docker-entrypoint-initdb.d/` para copiar um script que configura o banco de dados, o usuário e as permissões durante a inicialização do contêiner.

        * Defina o ponto de entrada: `ENTRYPOINT ["/docker-entrypoint-initdb.d/setup.sh"]` executa o script de inicialização durante a criação do contêiner.

    * **Arquivo de Configuração MariaDB (srcs/requirements/mariadb/conf/50-server.cnf):**

        * Configure o bloco `[mysqld]` para definir as configurações do servidor MariaDB.

        * Defina o diretório de dados: `datadir = /var/lib/mysql`.

        * Defina o socket: `socket = /run/mysqld/mysqld.sock`.

        * Permita conexões de qualquer IP: `bind_address = *`.

        * Defina a porta: `port = 3306`.

        * Defina o usuário: `user = mysql`.

    * **Script de Inicialização (srcs/requirements/mariadb/conf/setup.sh):**

        * Inicie o serviço MySQL.

        * Crie o banco de dados: Utilize `mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"` para criar o banco de dados especificado na variável de ambiente `SQL_DATABASE`.

        * Crie o usuário: Utilize `mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"` para criar o usuário especificado nas variáveis de ambiente `SQL_USER` e `SQL_PASSWORD`.

        * Conceda os privilégios: Utilize `mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"` para conceder todos os privilégios ao usuário na base de dados.

        * Defina a senha do root: Utilize `mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"` para definir a senha do root especificada na variável de ambiente `SQL_ROOT_PASSWORD`.

        * Atualize os privilégios:  `mysql -e "FLUSH PRIVILEGES;"`.

        * Reinicie o MySQL: Desligue e reinicie o MySQL para aplicar as configurações.

5. **Construção Detalhada do Container WordPress:**

    * **Dockerfile (srcs/requirements/wordpress/Dockerfile):**

        * Utilize `FROM debian:buster` como imagem base.

        * Atualize o APT: `RUN apt update -y` e `RUN apt upgrade -y`.

        * Instale o wget: `RUN apt-get -y install wget`.

        * Instale o PHP e suas dependências: `RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client`.

        * Baixe e descompacte o WordPress: Utilize `RUN wget <link para o arquivo .tar.gz do WordPress> -P /var/www` para baixar o WordPress e `RUN cd /var/www && tar -xzf <nome do arquivo .tar.gz> && rm <nome do arquivo .tar.gz>` para descompactá-lo. Certifique-se de usar a versão em francês e substituir os placeholders pelos valores corretos.

        * Defina o proprietário do diretório do WordPress: `RUN chown -R root:root /var/www/wordpress`.

        * Copie o arquivo de configuração do PHP: `COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf`.

        * Instale o WP-CLI: Baixe o WP-CLI, torne-o executável e mova-o para o diretório de binários: `RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`, `RUN chmod +x wp-cli.phar` e `RUN mv wp-cli.phar /usr/local/bin/wp`.

        * Copie o script de configuração automática: `COPY conf/auto_config.sh /`.

        * Crie o diretório `/run/php` se ele não existir: Utilize a instrução `RUN` para garantir que o diretório necessário para o PHP-FPM exista.

        * Defina o ponto de entrada: `ENTRYPOINT ["/auto_config.sh"]` para executar o script de configuração automática.

        * Execute o PHP-FPM: `CMD ["/usr/sbin/php-fpm7.3", "-F"]` inicia o PHP-FPM em primeiro plano.

    * **Arquivo de Configuração PHP (srcs/requirements/wordpress/conf/www.conf):**

        * Configure o PHP-FPM de acordo com as suas necessidades.
        * Adicione a linha `clear_env = no`.
        * Modifique a linha `listen` para `listen = wordpress:9000`.

    * **Script de Configuração Automática (srcs/requirements/wordpress/conf/auto_config.sh):**

        * Adicione um atraso de 10 segundos: `sleep 10` garante que o MariaDB esteja em execução antes de configurar o WordPress.

        * Crie o arquivo `wp-config.php`: Utilize a condicional `if [ ! -f /var/www/wordpress/wp-config.php ]; then` para verificar se o arquivo já existe e, caso contrário, execute o comando `wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'` para criar o arquivo com as informações do banco de dados.

        * Instale o WordPress: Utilize o comando `wp core install --url=https://$DOMAIN_NAME --title='<Título do Site>' --admin_user=<Nome de Usuário Admin> --admin_password=<Senha Admin> --admin_email=<Email Admin> --allow-root` para instalar o WordPress com as configurações especificadas. Substitua os placeholders pelos valores corretos.

        * Crie o segundo usuário: Utilize o comando `wp user create <Nome de Usuário> <Email> --role=author --first_name='<Nome>' --last_name='<Sobrenome>' --user_pass=<Senha> --allow-root` para criar o segundo usuário com a função de autor. Substitua os placeholders pelos valores corretos.

6. **Conexão dos Containers com Docker Compose:**

    * **Arquivo Docker Compose (srcs/docker-compose.yml):**

        * Defina a versão do Docker Compose: `version: '3'`.

        * Defina os serviços:
            * **MariaDB:**
                * `container_name: mariadb`.
                * `networks: - inception`.
                * `build: context: ./requirements/mariadb` e `dockerfile: Dockerfile`.
                * `env_file: .env`.
                * `volumes: - mariadb:/var/lib/mysql`.
                * `restart: unless-stopped`.
                * `expose: - "3306"`.

            * **NGINX:**
                * `container_name: nginx`.
                * `volumes: - wordpress:/var/www/wordpress`.
                * `networks: - inception`.
                * `depends_on: - wordpress`.
                * `build: context: ./requirements/nginx` e `dockerfile: Dockerfile`.
                * `env_file: .env`.
                * `ports: - "443:443"`.
                * `restart: on-failure`.

            * **WordPress:**
                * `container_name: wordpress`.
                * `env_file: .env`.
                * `volumes: - wordpress:/var/www/wordpress`.
                * `networks: - inception`.
                * `depends_on: - mariadb`.
                * `build: context: ./requirements/wordpress` e `dockerfile: Dockerfile`.
                * `restart: on-failure`.
                * `expose: - "9000"`.

        * Defina os volumes:
            * `wordpress: driver: local`, `driver_opts: type: 'none', o: 'bind'`, e `device: '<caminho para o volume wordpress na máquina host>'`.
            * `mariadb: driver: local`, `driver_opts: type: 'none', o: 'bind'`, e `device: '<caminho para o volume mariadb na máquina host>'`.

        * Defina a rede: `networks: inception: driver: bridge`.

7. **Finalização do Projeto:**

    * **Correções e Ajustes:** Revise todos os arquivos de configuração e Dockerfiles, garantindo que estejam de acordo com as especificações do projeto e corrigindo quaisquer erros encontrados durante os testes.

    * **Makefile:** Crie o `Makefile` para automatizar o processo de build e gerenciamento do projeto. Inclua comandos para construir as imagens, iniciar os contêineres, parar os contêineres, remover os contêineres e limpar o ambiente Docker.

    * **Configuração do Nome de Domínio:** Edite o arquivo `/etc/hosts` para adicionar uma entrada que mapeia o nome de domínio `login.42.fr` (substituindo `login` pelo seu login) para o endereço IP `127.0.0.1`.

    * **Acesso ao Site:** Acesse o site WordPress através do navegador usando a URL `https://login.42.fr`. Ignore os avisos de segurança do navegador, pois o certificado SSL é autoassinado e não é reconhecido como confiável.

**Considerações Finais:**

* **Segurança:** Armazene todas as informações confidenciais, como senhas e chaves de API, no arquivo `.env`, que deve ser adicionado ao `.gitignore` para evitar que seja versionado. 

* **Versões:** As versões dos softwares utilizados podem variar com o tempo. Verifique a documentação oficial do Docker e dos softwares para obter as versões mais recentes e realizar os ajustes necessários.

* **Enunciado do Projeto:** Este roadmap é um guia detalhado para o desenvolvimento do projeto Inception. No entanto, consulte o enunciado original do projeto para obter informações precisas e completas sobre os requisitos e critérios de avaliação.

* **Documentação:** Utilize a documentação oficial do Docker e dos softwares utilizados como referência para aprofundar seus conhecimentos e solucionar eventuais dúvidas.

</details>

### Study resources
Article / Forum | Tutorial | Video | Documentation
:------:|:--------:|:-----:|:-------------:
[grademe](https://tuto.grademe.fr/inception/) | [notebookLM](https://notebooklm.google.com/notebook/f7b3496f-d31d-493d-9e3b-67c4013256e7?_gl=1*12ihuzq*_ga*MTI1NTE1MTcxMS4xNzMxOTQ1OTcy*_ga_W0LDH41ZCB*MTczMTk0NTk3Mi4xLjEuMTczMTk0NjU0OC4wLjAuMA..&original_referer=https:%2F%2Fnotebooklm.google%23&pli=1) | [upsum]() | [upsum]()
