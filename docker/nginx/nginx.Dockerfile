FROM nginx:latest

# Copy nginx configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d
