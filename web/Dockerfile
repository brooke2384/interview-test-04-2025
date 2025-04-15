FROM php:8.4-fpm

WORKDIR /app
SHELL ["/bin/bash", "-c"]

# 1. Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# 2. Install system dependencies & Nginx
RUN apt-get update -y && apt-get install -y \
    nginx \
    openssl \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    git \
    zip \
    unzip

# 3. Install composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# 4. Install NVM
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=20.16.0
RUN mkdir -p $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# 5. Install Node & NPM
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# 6. Confirm Node & NPM installation
RUN node -v
RUN npm -v

# 7. Install PHP extensions
# NOTE: See https://github.com/mlocati/docker-php-extension-installer?tab=readme-ov-file#supported-php-extensions
#       for a list of extensions supported by this utility.
# NOTE: See https://laravel.com/docs/11.x/deployment#server-requirements for
#       a list of required PHP extensions.
# NOTE: Some PHP extensions are already installed in the php docker base image.
#       We can skip installing these. They can be found by adding
#       `RUN php -m && exit 1` above this comment.
RUN docker-php-ext-install gd pdo_mysql zip

# 8. Copy application files
COPY --chown=www-data:www-data . /app

# 9. Set write permissions
RUN chmod -R 755 /app/storage /app/bootstrap/cache

# 10. Install dependencies
RUN composer install --no-ansi --no-dev --no-interaction --optimize-autoloader
RUN npm ci

# 11. Confirm all platform requirements are installed
RUN composer check-platform-reqs

# 12. Set up environment file
RUN cp .env.production .env

# 13. Copy the Nginx config file
COPY nginx.conf /etc/nginx/nginx.conf

# 14. Test the Nginx config
RUN nginx -t

# 15. Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# 16. Build
RUN npm run build

# 17. Serve the application
CMD ["./entrypoint.sh"]
EXPOSE 8000
