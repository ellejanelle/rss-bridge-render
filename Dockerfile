FROM php:8.2-cli

# System deps
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    pkg-config \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
 && rm -rf /var/lib/apt/lists/*

# PHP extensions RSS-Bridge needs
RUN docker-php-ext-install -j$(nproc) curl dom simplexml mbstring

WORKDIR /app
# Shallow clone for faster builds
RUN git clone --depth 1 https://github.com/RSS-Bridge/rss-bridge .

# Defaults. You can still override these in Render → Environment
ENV WHITELIST_ALLOW_ALL=1 \
    CACHE=FileCache \
    CACHE_DIR=/app/cache \
    DEBUG=false

# Serve with PHP built in server on Render’s PORT
EXPOSE 10000
CMD php -S 0.0.0.0:${PORT:-10000} -t . index.php
