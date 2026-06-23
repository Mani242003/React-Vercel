# ✅ Stage 1: Build React App
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy only package files first (for better caching)
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install

# Copy remaining source code
COPY . .

# Build the Vite app
RUN npm run build

# ✅ Stage 2: Optional (for local container run)
FROM nginx:alpine AS runner

# Copy built files to nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]



