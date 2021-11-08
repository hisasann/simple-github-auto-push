FROM alpine:3.9

RUN apk --no-cache add openssl git curl openssh-client bash

COPY index.sh /index.sh

ENTRYPOINT [ "/index.sh" ]
