SHELL := /usr/bin/env bash -e

.PHONY: spec

all: init serv

init:
	./bin/setup

deps:
	bundle install --path vendor/bundle --binstubs bin/vendor

serv:
	bundle exec rails server

spec:
	bundle exec rake spec

test: spec
