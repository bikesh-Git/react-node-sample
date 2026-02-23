FROM node:18

WORKDIR /app

COPY server/package*.json ./server/
COPY client/package*.json ./client/

RUN cd server && npm ci
RUN cd client && npm ci && npm run build

COPY server ./server
COPY client/build ./server/public

EXPOSE 3000

CMD ["node", "server/index.js"]
