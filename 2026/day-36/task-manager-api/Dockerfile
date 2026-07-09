# ---------- Stage 1 : Install Dependencies ----------
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# ---------- Stage 2 : Production Image ----------
FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
