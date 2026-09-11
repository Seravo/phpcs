FROM ghcr.io/seravo/ubuntu:resolute

RUN apt-setup && \
    apt-get --assume-yes install \
      php-cli \
      php-xml && \
    apt-cleanup

RUN useradd user

# Install PHP CodeSniffer with WordPress and Security standards
# NOTE! PHP CodeSniffer master is development version, so one must use latest tagged version instead
RUN mkdir -p /usr/share/php/PHP /usr/share/php/PHPStan/PhpDocParser
COPY thirdparty/phpcs-core /usr/share/php/PHP/CodeSniffer
COPY thirdparty/wordpress /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/security /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcompatibility /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcsutils /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpcsextra /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/annotate-pull-request-from-checkstyle/cs2pr /usr/local/bin/
COPY thirdparty/slevomat-coding-standard /usr/share/php/PHP/CodeSniffer/src/Standards/
COPY thirdparty/phpdoc-parser/src/ /usr/share/php/PHPStan/PhpDocParser/

RUN chmod +x /usr/local/bin/cs2pr

USER user
COPY bin/ /usr/local/bin
COPY patches /opt/seravo/patches
ENTRYPOINT ["phpcs"]
