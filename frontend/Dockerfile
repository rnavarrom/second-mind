ARG NODE_VERSION=24.20.0-alpine

FROM node:${NODE_VERSION} AS builder

WORKDIR /app

RUN corepack enable
RUN corepack prepare pnpm@10 --activate

COPY package.json pnpm-lock.yaml ./

RUN pnpm install

COPY . .

RUN chown -R node:node /app

USER node

EXPOSE 5173

CMD ["pnpm", "run", "dev", "--host", "0.0.0.0"]