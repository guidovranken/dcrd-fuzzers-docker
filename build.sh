#!/bin/bash

cd /root

# Get, build libFuzzer
git clone https://github.com/guidovranken/libfuzzer-gv.git
cd libfuzzer-gv
make -j6
export LIBFUZZER_A_PATH=`realpath libFuzzer.a`
cd ..

# Get golang
wget https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
tar zxvf go1.11.1.linux-amd64.tar.gz
export GOROOT=`realpath go`
export GOPATH=$GOROOT/packages
mkdir $GOPATH
export PATH=$GOROOT/bin:$PATH

# Get dcrd
go get -u github.com/decred/dcrd

mkdir -p $GOPATH/src/github.com/guidovranken/
cd $GOPATH/src/github.com/guidovranken/

# Get libfuzzer-go
git clone https://github.com/guidovranken/libfuzzer-go.git

# Get dcrd fuzzers
git clone https://github.com/guidovranken/dcrd-fuzzers.git

mkdir -p /root/work
cd /root/work

# Build go-fuzz-build
go build github.com/guidovranken/libfuzzer-go/go-fuzz-build

export CC=clang
export CXX=clang++

cp /root/Makefile /root/work
cp /root/main.c /root/work
make all
