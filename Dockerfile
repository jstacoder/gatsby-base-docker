FROM node:slim

ARG PORT=8005

ARG VERSION=latest

ARG RELEASE=master

ENV PORT $PORT

ENV VERSION $VERSION

ENV RELEASE $RELEASE

RUN echo "building ${RELEASE} version: ${VERSION}"

RUN npm config set prefix /app/.node_modules

ENV PATH $PATH:/app/.node_modules/bin

RUN apt update && \
    apt upgrade -y && \
    apt install -y build-essential python-dev libvips-dev git --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g npm5

RUN mkdir /app

WORKDIR /app

ADD ./package.json /app/

RUN npm install -g yarn

RUN yarn global add gatsby-cli@$VERSION

RUN yarn install

EXPOSE 8000

EXPOSE 8005

CMD ["yarn", "develop"]

