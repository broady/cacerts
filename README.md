___DEPRECATED___: use [`gcr.io/distroless/base`](https://github.com/GoogleCloudPlatform/distroless/blob/master/base/README.md) instead.

I'll still keep this up-to-date, but new users should use distroless instead.

---

Green if up to date with Debian: [![Build Status](https://travis-ci.org/broady/cacerts.svg?branch=master)](https://travis-ci.org/broady/cacerts)

### debian_cpcerts.bash

```
set -e -x

apt-get update
apt-get install -y ca-certificates
cp /etc/ssl/certs/ca-certificates.crt .
```

### Makefile

```
.PHONY: img ca-certificates.crt

img: ca-certificates.crt
	docker build -t broady/cacerts .

ca-certificates.crt:
	docker run -v $(PWD):/cpcerts -w /cpcerts --rm -t debian:latest bash /cpcerts/debian_cpcerts.bash

SRCS=debian_cpcerts.bash Makefile Dockerfile
README.md: $(SRCS)
	for f in $(SRCS); do \
		echo "### $$(basename $$f)" && echo && \
		echo \`\`\` && tail -n+5 "$$f" && echo \`\`\` && echo; \
	done > README.md
```

### Dockerfile

```
FROM scratch

ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
```

