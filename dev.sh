#!/bin/bash -ex

redis-server --daemonize yes

export REDIS_URL=redis://localhost:6379/0

rackup config.ru
