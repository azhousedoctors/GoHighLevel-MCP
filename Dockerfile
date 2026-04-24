# Use Node.js 18 LTS
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

# Install all deps (incl. typescript) so `tsc` is available for the build
RUN npm ci

COPY . .

# Build TypeScript -> dist/
RUN npm run build

# Drop dev deps after build to keep runtime slim
RUN npm prune --production

EXPOSE 8000

ENV NODE_ENV=production

# `npm start` -> `node dist/http-server.js`
CMD ["npm", "start"]
