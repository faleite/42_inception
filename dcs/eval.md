# Parte obrigatória
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

## MariaDB e seu volume

- [ ] Certifique-se de que haja um `Dockerfile`.
- [ ] Certifique-se de que não haja `NGINX` no `Dockerfile`.
- [ ] Usando o comando `'docker compose ps'`, certifique-se de que o contêiner foi criado (usar o sinalizador `'-p'` é autorizado, se necessário).
- [ ] Certifique-se de que haja um **Volume**. Para fazer isso: Execute o comando `'docker volume ls'` e depois `'docker volume inspect <nome do volume>'`. Verifique se o resultado na saída padrão contém o caminho `'/home/login/data/'`, onde login é o login do aluno avaliado.
- [ ] O aluno avaliado deve ser capaz de explicar a você como fazer login no banco de dados. Verifique se o banco de dados não está vazio. Se algum dos pontos acima não estiver correto, o processo de avaliação termina agora.

### Parte obrigatória
Este projeto consiste em configurar uma pequena infraestrutura composta de diferentes serviços usando docker compose. Certifique-se de que todos os pontos a seguir estejam corretos.

Visão geral do projeto
A pessoa avaliada deve explicar a você em termos simples:

- [ ] Como o Docker e o Docker Compose funcionam
- [ ] A diferença entre uma imagem Docker usada com docker compose e sem docker compose
- [ ] O benefício do Docker em comparação com as VMs
- [ ] A pertinência da estrutura de diretório necessária para este projeto (um exemplo é fornecido no arquivo PDF do assunto).

## Noções básicas do Docker