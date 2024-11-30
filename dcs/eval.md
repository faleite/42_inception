# Parte obrigatória

## Testes preliminares
- [ ] Se houver suspeita de trapaça, a avaliação para aqui. Use o sinalizador "Trapaça" para denunciá-la. Tome essa decisão com calma, sabedoria e, por favor, use este botão com cautela.
- [ ] Quaisquer credenciais, chaves de API, variáveis ​​de ambiente devem ser definidas dentro de um arquivo `.env` durante a avaliação. Caso quaisquer credenciais, chaves de API estejam disponíveis no repositório git e fora do arquivo `.env` criado durante a avaliação, a avaliação para e a marca é 0.
- [ ] A defesa só pode acontecer se o aluno ou grupo avaliado estiver presente. Dessa forma, todos aprendem compartilhando conhecimento uns com os outros.
- [ ] Se nenhum trabalho tiver sido enviado (ou arquivos errados, diretório errado ou nomes de arquivo errados), a nota é 0 e o processo de avaliação termina.
- [ ] Para este projeto, você precisa clonar o repositório Git deles na estação deles.

## Instruções gerais
- [ ] Durante todo o processo de avaliação, se você não souber como verificar um requisito ou verificar alguma coisa, o aluno avaliado terá que ajudá-lo.
- [ ] Certifique-se de que todos os arquivos necessários para configurar o aplicativo estejam localizados dentro de uma pasta `srcs`. A pasta `srcs` deve estar localizada na raiz do repositório.
- [ ] Certifique-se de que um `Makefile` esteja localizado na raiz do repositório.
- [ ] Antes de iniciar a avaliação, execute este comando no terminal: 
```bash
docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
```
- [ ] Leia o arquivo `docker-compose.yml`. Não deve haver `'network: host'` nele ou `'links:'`. Caso contrário, a avaliação termina agora.
- [ ] Leia o arquivo `docker-compose.yml`. Deve haver `'network(s)'` nele. Caso contrário, a avaliação termina agora.
- [ ] Examine o `Makefile` e todos os scripts nos quais o Docker é usado. Não deve haver `'--link'` em nenhum deles. Caso contrário, a avaliação termina agora.
- [ ] Examine os `Dockerfiles`. Se você vir `'tail -f'` ou qualquer comando executado em segundo plano em qualquer um deles na seção `ENTRYPOINT`, a avaliação termina agora. 
  - [ ] A mesma coisa se `'bash'` ou `'sh'` forem usados, mas não para executar um script (por exemplo, `'nginx & bash'` ou `'bash'`).
- [ ] Examine os `Dockerfiles`. Os contêineres devem ser construídos a partir da penúltima versão estável do `Alpine` ou do `Debian`.
- [ ] Se o ponto de entrada for um script (por exemplo, `ENTRYPOINT ["sh", "my_entrypoint.sh"]`, `ENTRYPOINT ["bash", "my_entrypoint.sh"]`), certifique-se de que ele não execute nenhum programa em segundo plano (por exemplo, `'nginx & bash'`).
- [ ] Examine todos os scripts no repositório. Certifique-se de que nenhum deles execute um loop infinito. A seguir estão alguns exemplos de comandos proibidos: `'sleep infinity'`, `'tail -f /dev/null'`, `'tail -f /dev/random'`
- [ ] Execute o Makefile.

### Parte obrigatória
Este projeto consiste em configurar uma pequena infraestrutura composta de diferentes serviços usando docker compose. Certifique-se de que todos os pontos a seguir estejam corretos.

Visão geral do projeto
A pessoa avaliada deve explicar a você em termos simples:

- [ ] Como o Docker e o Docker Compose funcionam
- [ ] A diferença entre uma imagem Docker usada com docker compose e sem docker compose
- [ ] O benefício do Docker em comparação com as VMs
- [ ] A pertinência da estrutura de diretório necessária para este projeto (um exemplo é fornecido no arquivo PDF do assunto).

## Configuração simples
- [ ] Certifique-se de que o `NGINX` pode ser acessado somente pela `porta 443`. Uma vez feito isso, abra a página.
- [ ] Certifique-se de que um certificado SSL/TLS seja usado.
- [ ] Certifique-se de que o site WordPress esteja instalado e configurado corretamente (você não deve ver a página de instalação do WordPress). Para acessá-lo, abra `https://login.42.fr` no seu navegador, onde login é o login do aluno avaliado. Você não deve conseguir acessar o site via
- [ ] `http://login.42.fr`. Se algo não funcionar como esperado, o processo de avaliação termina agora.

## Noções básicas do Docker
- [ ] Comece verificando os Dockerfiles. Deve haver um Dockerfile por serviço. Certifique-se de que os Dockerfiles não sejam arquivos vazios. Se não for o caso ou se um Dockerfile estiver faltando, o processo de avaliação termina agora.
- [ ] Certifique-se de que o aluno avaliado tenha escrito seus próprios Dockerfiles e construído suas próprias imagens Docker. De fato, é proibido usar imagens prontas ou usar serviços como o DockerHub.
- [ ] Garanta que cada contêiner seja construído a partir da penúltima versão estável do Alpine/Debian. Se um Dockerfile não começar com `'FROM alpine:XXX'` ou `'FROM debian:XXXXX'`, ou qualquer outra imagem local, o processo de avaliação termina agora.
- [ ] As imagens do Docker devem ter o mesmo nome que o serviço correspondente. Caso contrário, o processo de avaliação termina agora.
- [ ] Certifique-se de que o `Makefile` tenha configurado todos os serviços via docker compose. Isso significa que os contêineres devem ter sido construídos usando docker compose e que nenhuma falha ocorreu. Caso contrário, o processo de avaliação termina.

## Rede Docker
- [ ] Certifique-se de que docker-network seja usado verificando o arquivo `docker-compose.yml`. Em seguida, execute o comando `'docker network ls'` para verificar se uma rede está visível.
- [ ] O aluno avaliado tem que lhe dar uma explicação simples de `docker-network`. Se algum dos pontos acima não estiver correto, o processo de avaliação termina agora.

## NGINX com SSL/TLS
- [ ] Certifique-se de que haja um Dockerfile.
- [ ] Usando o comando `'docker compose ps'`, certifique-se de que o contêiner foi criado (usar o sinalizador `'-p'` é autorizado, se necessário).
- [ ] Tente acessar o serviço via http (porta 80) e verifique se não consegue se conectar.
- [ ] Abra `https://login.42.fr/` no seu navegador, onde login é o login do aluno avaliado. A página exibida deve ser o site WordPress configurado (você não deve ver a página de instalação do WordPress).
- [ ] O uso de um certificado TLS v1.2/v1.3 é obrigatório e deve ser demonstrado. O certificado SSL/TLS não precisa ser reconhecido. Um aviso de certificado autoassinado pode aparecer. Se algum dos pontos acima não for explicado claramente e estiver correto, o processo de avaliação termina agora.

## WordPress com php-fpm e seu volume
- [ ] Certifique-se de que haja um Dockerfile.
- [ ] Certifique-se de que não haja NGINX no Dockerfile.
- [ ] Usando o comando `'docker compose ps'`, certifique-se de que o contêiner foi criado (usar o sinalizador `'-p'` é autorizado, se necessário).
- [ ] Certifique-se de que haja um Volume. Para fazer isso: Execute o comando `'docker volume ls'` e depois `'docker volume inspect <nome do volume>'`. Verifique se o resultado na saída padrão contém o caminho '/home/login/data/', onde login é o login do aluno avaliado.
- [ ] Certifique-se de que você pode adicionar um comentário usando o usuário WordPress disponível.
- [ ] Entre com a conta de administrador para acessar o painel de Administração. O nome de usuário Admin não deve incluir 'admin' ou 'Admin' (por exemplo, admin, administrator, Admin-login, admin-123 e assim por diante).
- [ ] No painel de Administração, edite uma página. Verifique no site se a página foi atualizada. Se algum dos pontos acima não estiver correto, o processo de avaliação termina agora.

## MariaDB e seu volume
- [ ] Certifique-se de que haja um `Dockerfile`.
- [ ] Certifique-se de que não haja `NGINX` no `Dockerfile`.
- [ ] Usando o comando `'docker compose ps'`, certifique-se de que o contêiner foi criado (usar o sinalizador `'-p'` é autorizado, se necessário).
- [ ] Certifique-se de que haja um **Volume**. Para fazer isso: Execute o comando `'docker volume ls'` e depois `'docker volume inspect <nome do volume>'`. Verifique se o resultado na saída padrão contém o caminho `'/home/login/data/'`, onde login é o login do aluno avaliado.
- [ ] O aluno avaliado deve ser capaz de explicar a você como fazer login no banco de dados. Verifique se o banco de dados não está vazio. Se algum dos pontos acima não estiver correto, o processo de avaliação termina agora.

### Persistência!
- [ ] Esta parte é bem direta. Você precisa reiniciar a máquina virtual. Depois que ela reiniciar, inicie o docker compose novamente. Então, verifique se tudo está funcional e se o WordPress e o MariaDB estão configurados. As alterações que você fez anteriormente no site WordPress ainda devem estar aqui. Se algum dos pontos acima não estiver correto, o processo de avaliação termina agora.