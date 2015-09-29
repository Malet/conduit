#!/bin/bash -ex

docker run --rm -it \
  -e REPO=$@ \
  -v ~/.ssh:/tmp/ssh \
  -v $(pwd)/git_cache:/git-cache \
  malet/conduit-runner \
  /workspace/git-getter.sh
