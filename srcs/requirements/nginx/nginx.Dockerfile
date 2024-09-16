FROM debian:stable

# Install NGINX
RUN apt-get update && apt-get install -y nginx openssl curl

# Generate a self-signed SSL certificate
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#     -keyout /etc/ssl/private/nginx-selfsigned.key \
#     -out /etc/ssl/certs/nginx-selfsigned.crt \
#     -subj "/C=DE/ST=Baden-Wuttemberg/L=Heilbronn/O=Ramygmbh/OU=Amazing/CN=ramoussa.42.fr"


# RUN cp /etc/ssl/certs/nginx-selfsigned.crt /usr/local/share/ca-certificates/nginx-selfsigned.crt

# Copy custom configuration files
# COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443 for HTTPS traffic
# EXPOSE 443
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]