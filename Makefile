.PHONY: img

img:
	docker run -v $(PWD):/cpcerts -w /cpcerts --rm -t debian:latest bash /cpcerts/debian_cpcerts.sh
	docker build -t broady/cacerts .
