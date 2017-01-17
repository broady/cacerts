# Copyright 2016 Google Inc. All rights reserved.
# Use of this source code is governed by the Apache 2.0
# license that can be found in the LICENSE file.

.PHONY: img ca-certificates.crt

img: ca-certificates.crt
	docker build -t broady/cacerts .

ca-certificates.crt:
	docker pull debian:latest
	docker run -v $(PWD):/cpcerts -w /cpcerts --rm -t debian:latest bash /cpcerts/debian_cpcerts.bash

SRCS=debian_cpcerts.bash Makefile Dockerfile
README.md: $(SRCS)
	for f in $(SRCS); do \
		echo "### $$(basename $$f)" && echo && \
		echo \`\`\` && tail -n+5 "$$f" && echo \`\`\` && echo; \
	done > README.md
