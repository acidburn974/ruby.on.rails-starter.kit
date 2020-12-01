#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
FILE=/usr/src/project/tmp/pids/server.pid

if test -f "$FILE"; then
    echo "Removing $FILE"
    rm -f $FILE
fi

BIN_DIR=/usr/src/project/bin

if -d BIN_DIR; then
	echo "chmod +x on /usr/src/project/bin"
	chmod +x /usr/src/project/bin/*
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
