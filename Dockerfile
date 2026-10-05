FROM node:22-alpine AS dependencies

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev


FROM node:22-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Le serveur sera lancé directement avec Node.js.
# npm et Yarn ne sont pas nécessaires dans l'image finale.
RUN rm -rf /usr/local/lib/node_modules/npm \
    /opt/yarn-* \
    /usr/local/bin/npm \
    /usr/local/bin/npx \
    /usr/local/bin/yarn \
    /usr/local/bin/yarnpkg

COPY --from=dependencies --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node package.json server.js ./

USER node

EXPOSE 3000

CMD ["node", "server.js"]
