# syntax=docker/dockerfile:1

ARG VERSION=3.15.3

###
FROM alpine:3.20 AS builder
RUN apk add --no-cache bash file git go make

ARG VERSION
ARG HOSTOS
ARG HOSTARCH

WORKDIR /app
# https://helm.sh/docs/intro/install/
RUN git clone https://github.com/helm/helm.git /app
RUN git checkout -b v${VERSION} v${VERSION}

#
ENV VERSION=${VERSION}
ENV GOOS=${HOSTOS}
ENV GOARCH=${HOSTARCH}

ENV INSTALL_PATH=/egress
RUN mkdir $INSTALL_PATH

RUN TARGETS=${HOSTOS}/${HOSTARCH} make install

#
CMD [ "bash" ]
