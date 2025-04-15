#!/bin/bash

# 1. Initialize storage directory
echo "Linking storage..."
php artisan storage:link

# 2. Initialise caches
echo "Running optimizations..."
php artisan optimize

# 3. Run migrations
echo "Running migrations..."
php artisan migrate --force

# 4. Start Nginx
echo "Starting Nginx..."
service nginx start

# 5. Start PHP FPM
echo "Starting PHP FPM..."
php-fpm
