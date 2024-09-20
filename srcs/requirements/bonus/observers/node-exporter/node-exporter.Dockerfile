FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


# download and extract node exporter

RUN curl -L -o /usr/local/bin/node_exporter.tar.gz \
    https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz \
    && tar -xzf /usr/local/bin/node_exporter.tar.gz -C /usr/local/bin \
    && rm /usr/local/bin/node_exporter.tar.gz

# expose port 9100
EXPOSE 9100

# start node exporter
CMD ["/usr/local/bin/node_exporter-1.8.2.linux-amd64/node_exporter"]