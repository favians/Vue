FROM node:latest

ARG NUXT_HOST="localhost"
ARG NUXT_PORT="3000"

ENV NUXT_HOST=${NUXT_HOST}
ENV NUXT_PORT=${NUXT_PORT}

WORKDIR 'app/'

COPY package.json .

RUN apk --no-cache --virtual build-dependencies add \
    python \
    make \
    g++ \
    && npm install \
    && apk del build-dependencies

COPY . .
EXPOSE 3000

RUN ["chmod", "+x", "entrypoint.sh"]

ENTRYPOINT [ "./entrypoint.sh" ]
