fmt:
	shfmt -w scripts

lint:
	shellcheck scripts/**/*.sh

test:
	bats tests

verify: fmt lint test

clean:
	rm -rf dist
