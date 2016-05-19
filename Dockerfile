FROM ubuntu:latest

RUN \
  apt-get update && \
  apt-get install -y ruby ruby-dev ruby-bundler && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /package_indexer

ADD lib /package_indexer/lib