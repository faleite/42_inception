FROM alpine:3.19.4

RUN apk update && apk upgrade && \
	apk add --no-cache nginx

# Criar diretório para os arquivos de configuração	
RUN mkdir -p /var/www/html

# Copiar arquivos de configuração
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY html/index.html /var/www/html/

# Expor porta 80
EXPOSE 80

# Comando para iniciar o NGINX em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
