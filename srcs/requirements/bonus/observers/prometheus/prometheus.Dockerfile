# Use a minimal Debian image as the base
FROM debian:bookworm-slim

# Set environment variables for version and directories
ENV PROMETHEUS_VERSION=2.54.0 \
    PROMETHEUS_USER=prometheus \
    PROMETHEUS_HOME=/opt/prometheus \
    PROMETHEUS_DATA_DIR=/prometheus

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a Prometheus user and directories
RUN useradd --no-create-home --shell /bin/false ${PROMETHEUS_USER} \
    && mkdir -p ${PROMETHEUS_HOME} ${PROMETHEUS_DATA_DIR} \
    && chown -R ${PROMETHEUS_USER}:${PROMETHEUS_USER} ${PROMETHEUS_HOME} ${PROMETHEUS_DATA_DIR}

# Download and install Prometheus
RUN curl -sSL https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz \
    | tar -xz -C ${PROMETHEUS_HOME} --strip-components=1

# Ensure Prometheus is owned by the Prometheus user
RUN chown -R ${PROMETHEUS_USER}:${PROMETHEUS_USER} ${PROMETHEUS_HOME}

# Expose the default Prometheus port
EXPOSE 9090

# Copy a default configuration (or you can mount your own at runtime)
COPY ./conf/alert.rules.yaml ${PROMETHEUS_HOME}/alert.rules
COPY ./conf/prometheus.yaml ${PROMETHEUS_HOME}/prometheus.yml

# Set user and working directory
USER ${PROMETHEUS_USER}
WORKDIR ${PROMETHEUS_HOME}

# Command to run Prometheus
CMD ["./prometheus", "--config.file=prometheus.yml", "--storage.tsdb.path=/prometheus"]
