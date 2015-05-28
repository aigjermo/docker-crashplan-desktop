FROM debian:jessie

# install prereqs
RUN apt-get update && \
    apt-get -qy --no-install-recommends install \
        openjdk-7-jre \
        libcanberra-gtk-module \
        cpio \
        curl

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
