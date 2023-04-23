FROM nginx:latest

ARG BUILD_DATE

LABEL \
  maintainer="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.authors="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.title="shamirs-secret-sharing" \
  org.opencontainers.image.description="Static site for using Shamir's Secret Sharing Scheme" \
  org.opencontainers.image.created=$BUILD_DATE

WORKDIR /app

COPY package.json .

RUN apt-get update && apt-get install -y \
    software-properties-common \
    npm
RUN npm install npm@latest -g && \
    npm install n -g && \
    n latest

RUN npm i
RUN npm run build

COPY . .

COPY version /

EXPOSE 8080