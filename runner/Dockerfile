FROM alpine
RUN apk update
RUN apk add \
  git \
  openssh \
  ruby

RUN mkdir -p /workspace
WORKDIR /workspace
COPY git-getter.sh git-getter.sh
