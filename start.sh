#!/bin/sh

#Fix permissions
chown -R nginx /selfoss/data

exec supervisord -c /etc/supervisor/supervisord.conf
