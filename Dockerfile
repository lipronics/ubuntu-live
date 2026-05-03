FROM ubuntu:24.04

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
    apt install -y \
     apache2 \
     barcode \
     build-essential \
     composer \
     curl \
     fonts-freefont-ttf \
     gcc \
     ghostscript \
     git \
     libapache2-mod-php \
     locales \
     nodejs \
     npm \
     php-bcmath \
     php-cli \
     php-curl \
     php-dev \
     php-fpm \
     php-gd \
     php-intl \
     php-mbstring \
     php-mysql \
     php-pear \
     php-redis \
     php-soap \
     php-ssh2 \
     pipx \
     sudo \
     supervisor \
     unoconv \
     unzip \
     wget \
     zip \
     && \
  apt clean

RUN a2dismod php8.3 && \
    a2dismod mpm_prefork && \
    a2enmod mpm_event && \
    a2enmod rewrite && \
    a2enmod expires && \
    a2enmod headers && \
    a2enmod ssl && \
    a2enmod http2 && \
    a2enmod proxy_fcgi && \
    a2enmod setenvif && \
    a2enconf php8.3-fpm && \
    phpenmod mbstring

RUN locale-gen nl_NL.utf8
