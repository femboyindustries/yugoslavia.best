# Use the official PHP image from Docker Hub
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev

COPY ./src/john /usr/src/john
WORKDIR /usr/src/john
RUN phpize && ./configure && make && make install

ENV john=true

RUN echo "extension=john.so" > /usr/local/etc/php/conf.d/john.ini

# Copy the application files to the working directory
COPY ./src /var/www/html

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]



