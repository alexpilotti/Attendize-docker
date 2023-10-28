FROM php:7.4-fpm
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
RUN apt update && apt install -y zlib1g-dev libpng-dev libzip-dev libxrender1 libpq-dev libjpeg-dev libpng-dev libfreetype6-dev libxext6 libfontconfig
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install bcmath gd zip pdo_mysql pdo_pgsql
RUN rm -rf /tmp/* /var/cache/*
RUN apt clean && rm -rf /var/lib/apt/lists/*
COPY php.ini /usr/local/etc/php/

