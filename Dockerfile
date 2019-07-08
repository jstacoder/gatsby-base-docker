FROM node:10-slim

ARG PORT=8000

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
    apt install -y build-essential python-dev libvips-dev git ssh --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g npm5

WORKDIR /app

RUN npm install -g yarn

RUN yarn global add gatsby-cli@$VERSION

EXPOSE $PORT

ENTRYPOINT ["yarn"]

CMD ["develop", "--host", "0.0.0.0", "--port", "${PORT}"]
