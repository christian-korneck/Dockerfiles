# docker build -t chko/tetris -f Dockerfile .
# docker run --rm -e VARIANT=bastet -ti chko/tetris
FROM debian:10
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="tetris" \
    org.label-schema.description="cmdline tetris" \
    org.label-schema.url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vendor="Christian Korneck <christian@korneck.de>" \
    maintainer="Christian Korneck <christian@korneck.de>" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
# without this builds on docker hub get stuck with interactive keyboard selection prompt
ARG DEBIAN_FRONTEND=noninteractive
# bastet
RUN apt-get update
RUN apt-get -y install bastet
# emacs
RUN apt-get -y install emacs
# ensure everything run.bash needs is there
RUN apt-get -y install bash coreutils
# copy entrypoint script
COPY run.bash /run.bash
RUN chmod a+x run.bash
# be unprived
RUN useradd -ms /bin/bash player
USER player
ENTRYPOINT /run.bash
