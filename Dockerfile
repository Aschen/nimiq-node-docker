FROM node:9.8

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git build-essential

RUN wget https://github.com/nimiq-network/core/archive/master.tar.gz \
    && tar xf ./master.tar.gz

WORKDIR /core-master

RUN npm install --unsafe
