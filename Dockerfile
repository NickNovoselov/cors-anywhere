FROM node:18-alpine
ENV NODE_ENV=production
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
ENV PATH /home/node/app/node_modules/.bin:$PATH
WORKDIR /home/node/app
COPY --chown=node:node package.json yarn.lock ./
USER node
RUN yarn config set network-timeout 600000 -g && yarn install --production
COPY --chown=node:node . .
EXPOSE 8080
CMD [ "node", "server.js" ]