FROM alpine:3.19.4

# Install NGINX and OpenSSL
RUN apk update && apk upgrade && \
	apk add --no-cache nginx openssl && \
	mkdir -p /etc/nginx/ssl

# Build a certificate and key for SSL
# RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 School/OU=faaraujo/CN=faaraujo/"

# NGINX configuration
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Command to start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
