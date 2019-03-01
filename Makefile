SHELL := /bin/bash

BUILD := `git rev-parse HEAD`

# Set VERSION from file if not passed in through env var
version_file:=VERSION
ifeq ($(VERSION),)
VERSION=`cat $(version_file)`
endif

# Set CI to false if not passed in
ifeq ($(CI),)
CI=false
endif

# Use linker flags to provide version/build settings to the target
#LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"

# go source files, ignore vendor directory
#SRCFILES = $(shell find . -type f -name '*.go' -not -path "./vendor/*" -not -name '*_gen.go' -not -path "./build/golang/*")
#GOPACKAGES = $(shell go list ./...  | grep -v /vendor/ | grep -v /serializers)
#SERIALIZERSPACKAGES = $(shell go list ./...  | grep -v /vendor/ | grep /serializers)
#JSONFILES = $(shell find . -type f -name '*.go' -path "./internal/pkg/calculations/types/*" -not -name '*_*.go')

.PHONY: build

default: deps build

deps:
	@go get -u github.com/golang/dep/cmd/dep
	@go get -u github.com/axw/gocov/gocov
	@go get -u -t github.com/tinylib/msgp
	@go get -u github.com/mailru/easyjson/...
	@dep ensure

build:
	go build $(LDFLAGS) -o testcase ./hello/hello.go
