FROM alpine:3.19.4

RUN apk update && apk upgrade && \
	apk add --no-cache nginx openssl vim curl && \
	mkdir -p /etc/nginx/ssl && \
	# mkdir -p /etc/nginx/ssl /var/www/html /var/run/nginx && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	# -out /etc/nginx/ssl/inception.csr \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 School/OU=faaraujo/CN=faaraujo/"
	# -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"
	
RUN mkdir -p /run/nginx

COPY conf/html /var/www/html
	
# RUN chmod 755 /var/www/html && \
# 	chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
