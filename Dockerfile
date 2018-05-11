FROM ubuntu
ENV TERM xterm

RUN mkdir -p /srv
WORKDIR /srv
COPY ./ ./

RUN apt-get -y update \
  && apt-get -y install curl wget xz-utils mysql-client netcat \
  && wget -O /usr/local/src/node-v10.0.0-linux-x64.tar.xz http://nodejs.org/dist/v10.0.0/node-v10.0.0-linux-x64.tar.xz \
  && tar -C /usr/local --strip-components 1 -xJvf /usr/local/src/node-v10.0.0-linux-x64.tar.xz

RUN npm install -g pm2 nodemon db-migrate db-migrate-mysql

EXPOSE 80
EXPOSE 8080
