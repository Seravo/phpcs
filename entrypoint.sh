#!/bin/sh
set -e

# Execute PHPCS

# If we're running in GitHub Actions, do some formatting
if [ -n "${GITHUB_ACTIONS}" ]
then
  /usr/bin/php /usr/local/bin/phpcs -q --report=checkstyle "$@" |/usr/local/bin/cs2pr
else
  /usr/bin/php /usr/local/bin/phpcs "$@"
fi
