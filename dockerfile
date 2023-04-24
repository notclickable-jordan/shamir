# First stage: build the React app using Node.js
FROM node:18-alpine as build-stage

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Second stage: serve the React app using nginx
FROM nginx:latest

ARG BUILD_DATE

LABEL \
  maintainer="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.authors="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.title="shamirs-secret-sharing-scheme" \
  org.opencontainers.image.description="Static site for using Shamir's Secret Sharing Scheme" \
  org.opencontainers.image.created=$BUILD_DATE

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY version /

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]