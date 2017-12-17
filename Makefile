SHELL := /usr/bin/env bash -e

BUNDLER_VERSION := '1.16'

all: nuke init test serv

app-clean:
	@echo "== deleting vendored gems  =="
	rm -rf .bundle ./vendor/bundle
	@echo "== deleting node modules  =="
	rm -rf ./node_modules
	@echo "== deleting configs  =="
	rm -rf ./config/cable.yml ./config/database.yml ./config/secrets.yml
	@echo "== deleting dot envs =="
	rm -rf .env.development .env.test

clean: app-clean


ruby-setup:
	@echo "== installing ruby"
	rbenv install --skip-existing

bundler-setup:
	@echo "== installing bundler v#{BUNDLER_VERSION} =="
	gem install bundler --conservative --no-document --no-force --version '~> ${BUNDLER_VERSION}'

setup: ruby-setup bundler-setup


app-configure:
	@echo "== creating config files =="
	cp config/cable.yml.sample config/cable.yml
	cp config/database.yml.sample config/database.yml
	cp config/secrets.yml.sample config/secrets.yml
	./bin/configure

configure: app-configure


app-bootstrap:
	@echo "== preparing database =="
	bundle exec rake db:setup
	@echo "== removing old logs and tempfiles =="
	bundle exec rake log:clear tmp:clear
	@echo "== Restarting application server =="
	bundler exec rake restart

bootstrap: app-bootstrap


bundler-install:
	@echo "== installing ruby depdencies =="
	bundler check || bundler install --path vendor/bundle --binstubs bin/vendor

yarnify-install:
	@echo "== installing javascript depdencies =="
	./bin/yarnify install

install: bundler-install yarnify-install


initialize: setup install configure bootstrap


app-update: bundler-setup bundler-install
	@echo "== updating database =="
	bundler exec rake db:migrate
	@echo "== removing old logs and tempfiles =="
	bundler exec rake log:clear tmp:clear
	@echo "== restarting application server =="
	bundler exec rake restart

update: app-update


app-server:
	bundler exec rails server

server: app-server


app-tests:
	bundle exec rake spec

tests: app-tests


nuke: clean
init: initialize
serv: server

test: tests

load: update
