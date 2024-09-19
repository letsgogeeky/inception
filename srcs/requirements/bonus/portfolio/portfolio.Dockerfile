FROM debian:bookworm-slim

# Install golang
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    golang \
    git

# Set env
ENV GO111MODULE=on
ENV GOPROXY=https://proxy.golang.org
# COPY the source code
COPY ./src /app

WORKDIR /app

RUN go mod download
RUN go build -o main

# Expose port 8080
EXPOSE 8080

# Start the app

CMD ["/app/main", "-port", "8080"]