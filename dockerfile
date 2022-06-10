FROM node:16-alpine

# System updates and dependencies
RUN apk update
RUN apk upgrade --available
RUN apk add vips

# Copy source files
RUN mkdir /srv/strapi
WORKDIR /srv/strapi
COPY ./.env ./.env
COPY ./src ./src
COPY ./config ./config
COPY ./package.json ./package.json
COPY ./public ./public

# Environment configuration
ENV NODE_ENV production
ARG NODE_ENV=${NODE_ENV}

# Run Strapi
RUN npm i -g yarn --force
RUN yarn install
RUN yarn build
EXPOSE 1337
CMD ["yarn", "start"]