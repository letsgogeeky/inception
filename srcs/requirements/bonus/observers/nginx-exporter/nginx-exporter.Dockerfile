FROM debian:bookworm-slim

# install nginx prometheus exporter
RUN apt-get update && apt-get install -y \
    wget curl

# download and extract nginx exporter
RUN curl -L -o /usr/local/bin/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz \
    https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.3.0/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz && \
    tar -xzf /usr/local/bin/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz -C /usr/local/bin && \
    rm /usr/local/bin/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz

# expose port 9113
EXPOSE 9113

# start nginx exporter
CMD ["/usr/local/bin/nginx-prometheus-exporter", "-nginx.scrape-uri=https://inception-nginx/metrics"]