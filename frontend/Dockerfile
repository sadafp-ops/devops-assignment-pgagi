# ---------- Build Stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ---------- Runtime Stage ----------
FROM node:20-alpine

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app ./

# Cloud Run listens on 8080
EXPOSE 8080

# IMPORTANT: use PORT env var directly
CMD ["sh", "-c", "PORT=${PORT} npm run start"]
