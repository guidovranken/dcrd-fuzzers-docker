FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential git clang wget

COPY main.c /root
COPY Makefile /root

COPY build.sh /root
RUN /root/build.sh
