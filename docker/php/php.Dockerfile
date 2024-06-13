# Stage 1: Build
FROM php:8.1-fpm as build

# Install dependencies needed for Laravel
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

# Set working directory
WORKDIR /var/www/app

# Copy composer.json and composer.lock
COPY composer.json composer.lock ./

# Install PHP dependencies using Composer
RUN composer install --no-scripts --no-autoloader --prefer-dist --no-dev

# Copy application code
COPY . .

RUN composer dump-autoload --optimize \
    && php artisan config:cache \
    && php artisan route:clear \
    && php artisan route:cache

# Stage 2: Runtime
FROM php:8.1-fpm

# Set working directory
WORKDIR /var/www/app

# Copy application from the build stage
COPY --from=build /var/www/app /var/www/app

#Salin ekstensi PHP dari tahap build
COPY --from=build /usr/local/lib/php/extensions/no-debug-non-zts-20210902 /usr/local/lib/php/extensions/no-debug-non-zts-20210902

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the entrypoint to PHP-FPM
CMD ["php-fpm"]
