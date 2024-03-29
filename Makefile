start:
	rm -rf tmp/pids/server.pid
	bin/rails s -b 0.0.0.0

setup: install db-prepare

install:
	bin/setup

db-prepare:
	bin/rails db:reset
	bin/rails db:fixtures:load

check: test lint

test:
	bin/rails test

lint:
	bundle exec rubocop -c .rubocop.yml
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop -A

copy-env:
	cp .env.example .env

.PHONY: test