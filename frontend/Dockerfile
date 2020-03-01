FROM node:8.15.1-jessie

RUN echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-key adv --fetch-keys "http://nginx.org/keys/nginx_signing.key"

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list 

RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get -y install nginx
RUN rm -rf /etc/nginx/conf.d/*
RUN mkdir -p /srv/www/

ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx_site.conf /etc/nginx/conf.d/default.conf

ADD entrypoint.sh /

RUN chmod +x entrypoint.sh

ADD package.json /tmp/
RUN cd /tmp && npm install

ADD . /code/
RUN rm -rf /code/node_modules
RUN cp -a /tmp/node_modules /code/node_modules

WORKDIR /code

EXPOSE 8080
CMD ["npm start"] 