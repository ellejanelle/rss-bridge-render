FROM php:8.2-cli

WORKDIR /app
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/RSS-Bridge/rss-bridge .

# defaults. you can still override from Render env
ENV WHITELIST_ALLOW_ALL=1
ENV CACHE=FileCache
ENV CACHE_DIR=/app/cache
ENV DEBUG=false

EXPOSE 10000
CMD php -S 0.0.0.0:${PORT:-10000} -t . index.php
