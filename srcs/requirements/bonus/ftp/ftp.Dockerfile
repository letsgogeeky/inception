FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    vsftpd && rm -rf /var/lib/apt/lists/*

COPY ./tools/vsftp_init.sh vsftp_init.sh

RUN chmod +x vsftp_init.sh

EXPOSE 20 21 30000-30009

CMD ["./vsftp_init.sh"]