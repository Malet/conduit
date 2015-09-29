#!/bin/sh -ex

cp -R /tmp/ssh /root/.ssh
CACHE_DIR=/git-cache/$REPO
mkdir -p ${CACHE_DIR}
yes | git -C ${CACHE_DIR} clone ${REPO} ${CACHE_DIR}
git -C ${CACHE_DIR} fetch --all
