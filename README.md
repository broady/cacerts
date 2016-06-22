### debian_cpcerts.sh

```
#!/bin/bash

set -e -x

apt-get update
apt-get install -y ca-certificates
cp /etc/ssl/certs/ca-certificates.crt .
```

### Makefile

```
.PHONY: img

img:
	docker run -v $(PWD):/cpcerts -w /cpcerts --rm -t debian:latest bash /cpcerts/debian_cpcerts.sh
	docker build -t broady/cacerts .

SRCS=debian_cpcerts.sh Makefile Dockerfile
README.md: $(SRCS)
	for f in $(SRCS); do \
		echo "### $$(basename $$f)" && echo && \
		echo \`\`\` && cat "$$f" && echo \`\`\` && echo; \
	done > README.md
```

### Dockerfile

```
FROM scratch

ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
```

