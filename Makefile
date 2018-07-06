.PHONY: all test lint

all: lint test

lint:
	@vint autoload
	@vimlparser autoload/*.vim > /dev/null

test:
	@themis
