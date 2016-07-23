#!/bin/sh

#Create needed folders
mkdir -p /selfoss/data/cache /selfoss/data/favions /selfoss/data/logs \
      /selfoss/data/thumbnails /selfoss/data/sqlite

#Fix permissions
chown -R nginx /selfoss/data

exec supervisord -c /etc/supervisor/supervisord.conf
