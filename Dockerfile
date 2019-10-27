FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y nano nginx php-mysql php-fpm php-curl php-xml supervisor git curl php-gd ssmtp

RUN ln -sf /app/conf/nginx.conf /etc/nginx/nginx.conf && \
    ln -sf /app/conf/php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf && \
    ln -sf /app/conf/php.ini /etc/php/7.2/fpm/php.ini

WORKDIR /app

# Install app
COPY . /app

RUN groupadd -r app -g 1000 && \
    useradd -u 1000 -r -g app -d /app -s /bin/bash -c "Docker image user" app && \
    chown -R app:app /app /var/lib/nginx

USER 1000

VOLUME /var/lib/nginx
EXPOSE 8000
CMD ["/app/conf/launch.sh"]
