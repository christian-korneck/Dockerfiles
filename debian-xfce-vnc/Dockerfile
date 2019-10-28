# docker build -t chko/debian-xfce-vnc -f Dockerfile .
# docker run --rm --name debian-xfce-vnc --hostname debian-xfce-vnc --shm-size 2g -p 5901:5901 -e VNCPASSWD=password -e VNCRES=1280x1024 -ti chko/debian-xfce-vnc
FROM debian:10
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="debian-xfce-vnc" \
    org.label-schema.description="A minimal Debian 10 Desktop (with xfce, firefox, thunderbird, libre office), accessible via VNC." \
    org.label-schema.url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vendor="Christian Korneck <christian@korneck.de>" \
    maintainer="Christian Korneck <christian@korneck.de>" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
# without this builds on docker hub get stuck with interactive keyboard selection prompt
ARG DEBIAN_FRONTEND=noninteractive
# xfce + vncserver
RUN apt-get update
RUN apt-get -y install xfce4 xfce4-goodies
RUN apt-get -y install tightvncserver
# ensure everything run.bash needs is there
RUN apt-get -y install procps bash coreutils openssl
# install sudo (so the interactive user is unprivileged by default but can elevate)
RUN apt-get -y install sudo
# make sudo usage passwordless for members of the "sudo" group (we don't set a password for our default/unprivileged user)
RUN echo %sudo ALL=NOPASSWD: ALL > /etc/sudoers.d/sudo-nopasswd
# install some goodies (no hard requirement)
RUN apt-get -y install firefox-esr
RUN apt-get -y install thunderbird
RUN apt-get -y install vim
RUN apt-get -y install libreoffice
# copy run script
COPY run.bash /run.bash
RUN chmod a+x /run.bash
# vnc server config
# (note: we don't use $HOME/.vnc/xstartup as we want to be able to map $HOME to a Docker volume)
# RUN echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &\n' > /etc/vnc/xstartup
RUN mkdir /etc/vnc
RUN echo '#!/bin/bash\nstartxfce4 &\n' > /etc/vnc/xstartup
# xstartup needs to be executable (for at least the user who runs vnc server)
RUN chmod 755 /etc/vnc/xstartup
# create user
RUN useradd -ms /bin/bash ehlo
RUN usermod -aG sudo ehlo
# from this point on we'll use the "ehlo" user -> $HOME points to  its  home dir (not root's)
USER ehlo
WORKDIR /home/ehlo
# create user .vnc dir (needed for vncpasswd in run script) and symlink xstartup file (so it can get updated even when the home dir is a volume)
RUN mkdir $HOME/.vnc
RUN ln -s /etc/vnc/xstartup $HOME/.vnc/xstartup
# the USER env var needs to be explicitly set (not the case with the Debian 10 docker base image), otherwise vncserver refuses to start
ENV USER ehlo
# the vnc port
EXPOSE 5901
# persist home dir
VOLUME /home/ehlo
# ENTRYPOINT /usr/bin/vncserver && while true; do sleep 30; done
ENTRYPOINT /run.bash
