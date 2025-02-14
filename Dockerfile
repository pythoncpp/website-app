FROM httpd:alpine3.21
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 80
