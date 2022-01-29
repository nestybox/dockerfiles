.PHONY: clean

arch := $(shell dpkg --print-architecture)

default: Dockerfile get-inner-img.sh
	./get-inner-img.sh
	docker build -t ghcr.io/nestybox/test-syscont:$(arch) .

clean:
	./get-inner-img.sh -c
