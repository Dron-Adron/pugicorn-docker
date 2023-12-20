FROM nginx:alpine

RUN apk update && \
    apk upgrade && \
    mkdir -p /etc/nginx/sites-available/ /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/conf.d/default.conf && \
    rm -rf /var/www/* && \
    adduser -D myuser && \
    addgroup mygroup && \
    adduser myuser mygroup && \
    sed -i 's/user nginx;/user myuser;/g' /etc/nginx/nginx.conf && \
    nginx -t && \
    rm -f /etc/nginx/conf.d/default.conf

COPY my_project.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/my_project.conf /etc/nginx/sites-enabled/

COPY my_project.conf /etc/nginx/conf.d/
COPY index.html /var/www/my_project/
COPY img.jpg /var/www/my_project/img/

RUN chmod -R 755 /var/www/my_project && \
    chown -R root:root /var/www/my_project

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
