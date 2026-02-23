FROM node:18

WORKDIR /app

COPY client/package*.json ./client/
COPY server/package*.json ./server/

RUN cd client && npm ci
RUN cd server && npm ci

COPY client ./client
RUN cd client && npm run build

COPY server ./server
COPY client/dist ./server/public

EXPOSE 3000

CMD ["node", "server/index.js"]
