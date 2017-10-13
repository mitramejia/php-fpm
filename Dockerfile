FROM johnpbloch/phpfpm:7.0

RUN curl -L https://phar.phpunit.de/phpunit.phar > /tmp/phpunit.phar \
	&& chmod +x /tmp/phpunit.phar \
	&& mv /tmp/phpunit.phar /usr/local/bin/phpunit

RUN apt-get update && apt-get install -y \
	git \
	subversion \
	wget \
	libxml2-dev \
	ssmtp

# install RVM, Ruby, and Bundler
RUN \curl -L https://get.rvm.io | bash -s stable --ruby
RUN /bin/bash -l -c "gem install wordmove"

RUN docker-php-ext-install soap
RUN echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

CMD ["php-fpm"]

EXPOSE 9000
