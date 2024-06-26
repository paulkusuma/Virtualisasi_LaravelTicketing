# Stage 1: Build
FROM php:8.1-fpm as build

# Instalasi dependensi yang dibutuhkan untuk Laravel
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Mengatur direktori kerja
WORKDIR /var/www/app

# Menyalin composer.json dan composer.lock
COPY composer.json composer.lock ./

# Instal dependensi PHP menggunakan Composer
RUN composer install --no-scripts --no-autoloader --prefer-dist --no-dev

# Copy application code
COPY . .

# Menghasilkan file autoload dan cache
RUN composer dump-autoload --optimize \
    && php artisan config:cache \
    && php artisan route:cache

# Stage 2: Runtime
FROM php:8.1-fpm

# Mengatur direktori kerja
WORKDIR /var/www/app

# Menyalin aplikasi dari tahap build
COPY --from=build /var/www/app /var/www/app

# Menyalin ekstensi PHP dari tahap build
COPY --from=build /usr/local/lib/php/extensions/no-debug-non-zts-20210902 /usr/local/lib/php/extensions/no-debug-non-zts-20210902

# Membuka port 9000 untuk PHP-FPM
EXPOSE 9000

# Menetapkan entrypoint ke PHP-FPM
CMD ["php-fpm"]
