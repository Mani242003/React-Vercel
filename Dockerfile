# Stage 1: Build
FROM node:20 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# 🔥 This creates /app/dist
RUN npm run build

# Stage 2: Lightweight image
FROM nginx:alpine

WORKDIR /app

# Only copy build output
COPY --from=builder /app/dist ./dist

# Debug check (optional)
RUN ls -la /app

CMD ["npx", "serve", "dist"]
