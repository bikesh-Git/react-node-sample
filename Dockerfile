# Build React
FROM node:20-alpine AS client-build
WORKDIR /app/client
COPY client/package*.json ./
RUN npm ci
COPY client .
RUN npm run build

# Build Node server
FROM node:20-alpine
WORKDIR /app
COPY server/package*.json ./
RUN npm ci
COPY server .

# copy React build into Node public folder
COPY --from=client-build /app/client/dist ./public

EXPOSE 3000
CMD ["node", "index.js"]
