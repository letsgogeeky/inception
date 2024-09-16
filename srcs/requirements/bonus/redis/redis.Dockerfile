FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    redis-server

# update config
RUN echo "maxmemory 512mb" >> /etc/redis/redis.conf
# Least Recently Used (LRU) policy
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf
# Enable AOF persistence (we can later use this file to restore the database)
RUN echo "appendonly yes" >> /etc/redis/redis.conf

# allow binding to all interfaces
RUN sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf
# Expose port 6379 for Redis
EXPOSE 6379

# Start Redis
CMD ["redis-server", "--protected-mode", "no"]