
IMAGE_NAME = mojo-701-perl-516

build:
	docker build -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate -f Dockerfile.$(IMAGE_NAME) .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
