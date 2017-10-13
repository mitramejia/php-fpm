FROM johnpbloch/phpfpm:7.0

RUN curl -L https://phar.phpunit.de/phpunit.phar > /tmp/phpunit.phar \
	&& chmod +x /tmp/phpunit.phar \
	&& mv /tmp/phpunit.phar /usr/local/bin/phpunit

RUN apt-get update && apt-get install -y \
	git \
	subversion \
	wget \
	libxml2-dev \
	ssmtp \
	libgdbm-dev \
	libncurses5-dev \
	automake \
	libtool \
	bison \
	libffi-dev 

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN source ~/.rvm/scripts/rvm
RUN rvm install 2.4.2
RUN rvm use 2.4.2 --default

RUN gem install wordmove

RUN docker-php-ext-install soap
RUN echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

CMD ["php-fpm"]

EXPOSE 9000
