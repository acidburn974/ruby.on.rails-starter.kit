#!/bin/sh
set -e

FILE=/usr/src/app/tmp/pids/server.pid

if test -f "$FILE"; then
    echo "Removing $FILE"
    rm -f $FILE
fi

# Remove a potentially pre-existing server.pid for Rails.

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"