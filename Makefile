.PHONY: help deps test

help:
	@echo "Targets available:"
	@echo "   deps:          Install testing dependencies"

all: deps test

deps:
	cd puppet ; \
	bundle install --path vendor ; \
	bundle exec librarian-puppet update

test:
	cd puppet ; \
	bundle exec rake lint ; \
	bundle exec rake validate ; \
	bundle exec rake validate_yaml
