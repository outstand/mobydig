FROM docker/for-desktop-kernel:4.19.76-ce15f646db9b062dc947cfc0c1deab019fa63f96-amd64 as kernel

FROM sysdig/sysdig:latest
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY --from=kernel / /usr/src/

RUN set -eux; \
      \
      cd /; \
      tar -xf /usr/src/kernel.tar; \
      cd /usr/src/; \
      tar -xf linux.tar.xz; \
      cd /lib/modules/$(uname -r); \
      rm build; \
      ln -s /usr/src/linux build

RUN set -eux; \
      \
      apt-get update; \
      apt-get --fix-broken --yes install; \
      DEBIAN_FRONTEND="noninteractive" apt-get --yes install \
        bison \
        flex \
      ;

RUN set -eux; \
      \
      cd /usr/src/linux; \
      zcat /proc/1/root/proc/config.gz > .config; \
      make modules_prepare; \
      make headers_install INSTALL_HDR_PATH=/usr


ENV SYSDIG_BPF_PROBE ""
ENV SYSDIG_HOST_ROOT /host

RUN set -eux; \
      \
      /usr/bin/sysdig-probe-loader
