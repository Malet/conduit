#!/bin/sh -ex

cp -R /tmp/ssh /root/.ssh
CACHE_DIR=/git-cache/$REPO
mkdir -p ${CACHE_DIR}

if [ -d ${CACHE_DIR}/.git ]
then
  git -C ${CACHE_DIR} fetch --all
else
  git -C ${CACHE_DIR} clone ${REPO} ${CACHE_DIR}
fi
