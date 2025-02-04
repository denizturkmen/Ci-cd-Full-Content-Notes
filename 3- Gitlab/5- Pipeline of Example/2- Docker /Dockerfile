FROM ubuntu
LABEL Deniz TÜRKMEN <turkmenn.deniz@gmail.com>
RUN apt update && apt install -y nginx
WORKDIR /var/www/html
COPY . /var/www/html/
EXPOSE 80
CMD nginx -g 'daemon off;'