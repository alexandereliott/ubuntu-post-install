# Base docker image
ARG DISTRO
ARG CODE_NAME
FROM ${DISTRO}:${CODE_NAME}
LABEL maintainer "Prasad Tengse <tprasadtp@users.noreply.github.com>"
ENV DEBIAN_FRONTEND noninteractive
# Install essentials
WORKDIR /shared
# hadolint ignore=DL3008
RUN apt-get -qq update \
    && apt-get install -qq -y --no-install-recommends \
      wget \
      whiptail \
      iputils-ping \
      procps \
      ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
