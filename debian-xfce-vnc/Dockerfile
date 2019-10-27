# docker build -t chko/debian-xfce-vnc -f Dockerfile .
# docker run --rm --name debian-xfce-vnc --hostname debian-xfce-vnc --shm-size 2g -p 5901:5901 -e VNCPASSWD=password -e VNCRES=1280x1024 -ti chko/debian-xfce-vnc
FROM debian:10
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
# create user
RUN useradd -ms /bin/bash ehlo
RUN usermod -aG sudo ehlo
# from this point on we'll use the "ehlo" user -> $HOME points to  its  home dir (not root's)
USER ehlo
WORKDIR /home/ehlo
# create xstartup
RUN mkdir $HOME/.vnc
RUN echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &\n' > $HOME/.vnc/xstartup
RUN chmod +x $HOME/.vnc/xstartup
# the USER env var needs to be explicitly set (not the case with the Debian 10 docker base image), otherwise vncserver refuses to start
ENV USER ehlo
# the vnc port
EXPOSE 5901
# persist home dir
VOLUME /home/ehlo
# ENTRYPOINT /usr/bin/vncserver && while true; do sleep 30; done
ENTRYPOINT /run.bash
