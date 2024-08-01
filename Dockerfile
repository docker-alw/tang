# vim:set ft=dockerfile:

#####################
### Builder Container
#####################

# hadolint ignore=DL3007
FROM alpine:latest AS builder

# hadolint ignore=DL3018
RUN apk --no-cache add \
        asciidoc \
        alpine-sdk \
        curl \
        doas \
        gcc \
        git \
        iproute2-ss \
        jose \
        jose-dev \
        llhttp-dev \
        meson \
        musl-dev \
        socat

COPY pkg/ /app/

RUN adduser -g build -D build \
        && addgroup build wheel \
        && addgroup build abuild \
        && echo "permit nopass :wheel" > /etc/doas.d/wheel.conf \
        && mkdir -p /var/cache/distfiles \
        && chgrp abuild /var/cache/distfiles /app \
        && chmod g+w /var/cache/distfiles /app

USER build
WORKDIR /app

ARG VERSION=15
ARG PKGVERSION=0

RUN abuild-keygen -a -i -n \
        && abuild

###################
#### Main Container
###################

# hadolint ignore=DL3007
FROM alpine:latest

ARG VERSION=15
ARG PKGVERSION=0

COPY test.sh /test.sh
COPY --from=builder /home/build/packages/*/tang-${VERSION}-r${PKGVERSION}.apk /var/cache/tang-${VERSION}-r${PKGVERSION}.apk

RUN apk --no-cache add --allow-untrusted "/var/cache/tang-${VERSION}-r${PKGVERSION}.apk"

VOLUME /var/db/tang

EXPOSE 9090

USER tang

ENTRYPOINT ["/bin/tangd"]
CMD ["--listen", "--port", "9090", "/var/db/tang"]
