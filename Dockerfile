FROM php:8.2-cli

# System packages
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    pkg-config \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
 && rm -rf /var/lib/apt/lists/*

# PHP extensions needed by RSS-Bridge
RUN docker-php-ext-install -j$(nproc) curl dom simplexml mbstring

WORKDIR /app
# Shallow clone for faster builds
RUN git clone --depth 1 https://github.com/RSS-Bridge/rss-bridge .

# Defaults. You can still override in Render → Environment
ENV WHITELIST_ALLOW_ALL=1 \
    CACHE=FileCache \
    CACHE_DIR=/app/cache \
    DEBUG=false

# Serve on Render's assigned PORT
EXPOSE 10000
CMD php -S 0.0.0.0:${PORT:-10000} -t . index.php
