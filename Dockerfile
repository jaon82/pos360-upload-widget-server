FROM node:20.18 AS base

FROM base AS dependencies
WORKDIR /usr/src/app
COPY package*.json .
RUN npm install

FROM base AS build
WORKDIR /usr/src/app
COPY . .
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
RUN npm run build
RUN npm prune --prod

#FROM node:20-alpine3.21 AS deploy
# Google
#FROM gcr.io/distroless/nodejs20-debian12 AS deploy
# Chainguard
FROM cgr.dev/chainguard/node AS deploy
USER 1000
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/package.json ./package.json
ENV CLOUDFLARE_ACCOUNT_ID="#"
ENV CLOUDFLARE_ACCESS_KEY_ID="#"
ENV CLOUDFLARE_SECRET_ACCESS_KEY="#"
ENV CLOUDFLARE_BUCKET="#"
ENV CLOUDFLARE_PUBLIC_URL="http://localhost"
ENV DATABASE_URL="postgresql://docker:docker@localhost:5432/upload"
EXPOSE 3333
CMD ["dist/infra/http/server.js"]
