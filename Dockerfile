FROM debian:jessie

# install prereqs
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update -q && \
    apt-get -qy --no-install-recommends install \
        openjdk-7-jre \
        libcanberra-gtk-module \
        cpio \
        curl \
        socat; \
    apt-get autoremove --purge -qy && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

WORKDIR /src
ENV CRASHPLAN_VERSION="4.2.0"

# add install script
COPY crashplan-install.sh /src/

# download and unpack crashplan
RUN curl -SL http://download.code42.com/installs/linux/install/CrashPlan/CrashPlan_${CRASHPLAN_VERSION}_Linux.tgz \
    | tar -xz \
    && sh crashplan-install.sh

COPY start.sh /

CMD ["sh", "/start.sh"]
