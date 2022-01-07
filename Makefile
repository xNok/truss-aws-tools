SHELL = /bin/sh
VERSION = 3.0

all: install

go_version: .go_version.stamp
.go_version.stamp: bin/check-go-version
	bin/check-go-version
	touch .go_version.stamp

lambda_build: test
	bin/make-lambda-build

lambda_release: lambda_build
	bin/make-lambda-release $(S3_BUCKET) $(VERSION)

install: pre-commit-install test
	go install github.com/trussworks/truss-aws-tools/...

.PHONY: test
test:
	bin/make-test