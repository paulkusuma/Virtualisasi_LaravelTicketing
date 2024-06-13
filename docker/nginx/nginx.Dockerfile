# Menggunakan image dasar Nginx versi terbaru
FROM nginx:latest

# Menyalin file konfigurasi utama Nginx ke dalam container
COPY nginx.conf /etc/nginx/nginx.conf

# Menyalin direktori 'conf.d' yang berisi file konfigurasi tambahan ke dalam container
COPY conf.d /etc/nginx/conf.d
