FROM php:8.2-cli

# system deps for curl and SSL
RUN apt-get update && apt-get install -y git unzip libcurl4-openssl-dev libssl-dev && rm -rf /var/lib/apt/lists/*

# PHP extensions RSS-Bridge needs
RUN docker-php-ext-install curl mbstring dom simplexml

WORKDIR /app
RUN git clone https://github.com/RSS-Bridge/rss-bridge .

# defaults. you can still override in Render
ENV WHITELIST_ALLOW_ALL=1
ENV CACHE=FileCache
ENV CACHE_DIR=/app/cache
ENV DEBUG=false

EXPOSE 10000
CMD php -S 0.0.0.0:${PORT:-10000} -t . index.php
