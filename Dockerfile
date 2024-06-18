FROM ghcr.io/seravo/ubuntu:noble

RUN apt-setup && \
    apt-get --assume-yes install \
      php-cli \
      php-xml && \
    apt-cleanup

RUN useradd user

# Install PHP CodeSniffer with WordPress and Security standards
# NOTE! PHP CodeSniffer master is development version, so one must use latest tagged version instead
RUN mkdir -p /usr/share/php/PHP
COPY thirdparty/phpcs-core /usr/share/php/PHP/CodeSniffer
COPY thirdparty/wordpress /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/security /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcompatibility /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcsutils /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcsextra /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/annotate-pull-request-from-checkstyle/cs2pr /usr/local/bin/

RUN ln -s /usr/share/php/PHP/CodeSniffer/bin/phpcs /usr/local/bin/phpcs && \
    ln -s /usr/share/php/PHP/CodeSniffer/bin/phpcbf /usr/local/bin/phpcbf && \
    chmod +x /usr/local/bin/cs2pr

USER user

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
