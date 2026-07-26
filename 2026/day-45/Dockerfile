# Use a specific Nginx Alpine version
FROM nginx:1.29-alpine

# Image metadata
LABEL maintainer="Jaishree Chaure"
LABEL project="GitHub Actions Practice"
LABEL description="Static website served using Nginx"

# Remove default Nginx website files
RUN rm -rf /usr/share/nginx/html/*

# Copy website files
COPY . /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider  http://localhost || exit 1

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]