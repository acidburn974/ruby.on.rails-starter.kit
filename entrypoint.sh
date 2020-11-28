#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
FILE=/usr/src/app/tmp/pids/server.pid

if test -f "$FILE"; then
    echo "Removing $FILE"
    rm -f $FILE
fi

YARN=/usr/src/app/bin/yarn

if test -f "/usr/src/app/bin/yarn"; then
	echo "chmod on /usr/src/app/bin"
	chmod +x /usr/src/app/bin/*
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"