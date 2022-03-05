FROM node:16 as build
WORKDIR /usr/src/app
ADD . .

FROM node:16-slim as running
WORKDIR /usr/src/app
HEALTHCHECK CMD node healthcheck
EXPOSE 3000

FROM build as build-dev
RUN npm ci

FROM running as development
COPY --from=build-dev /usr/src/app .
CMD ["npm", "run", "start:dev"]

FROM build as build-prod
RUN npm ci --production

FROM running as production
COPY --from=build-prod /usr/src/app .
CMD ["node", "server.js"]