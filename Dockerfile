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

#Install the barcode utility
RUN wget https://www.lisaas.com/download/genbarcode-0.4.tar.gz && \
    tar -xvzf genbarcode-0.4.tar.gz && \
    cd genbarcode-0.4/ && \
    make && \
    make install

ENV PIPX_HOME=/opt/pipx
ENV PIPX_BIN_DIR=/usr/local/bin
RUN pipx ensurepath && \
    pipx install unoserver==2.0.1
RUN npm install bower -g

#For session data storage:
RUN mkdir /home/www-session && \
    chown www-data /home/www-session

#For tmp upload files:
RUN mkdir /home/apache && \
    mkdir /home/apache/data && \
    chown -R www-data /home/apache

EXPOSE 80 443
