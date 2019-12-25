# docker build -t chko/subnetcalc -f Dockerfile .
# docker run --rm chko/subnetcalc 10.0.0.0/8
FROM debian:10
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="subnetcalc" \
    org.label-schema.description="subnetcalc on Debian" \
    org.label-schema.url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/christian-korneck/Dockerfiles" \
    org.label-schema.vendor="Christian Korneck <christian@korneck.de>" \
    maintainer="Christian Korneck <christian@korneck.de>" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
# without this builds on docker hub get stuck with interactive keyboard selection prompt
ARG DEBIAN_FRONTEND=noninteractive
# subnetcalc
RUN apt-get update
RUN apt-get -y install subnetcalc
# be unprived
RUN useradd -ms /bin/bash container
USER container
ENTRYPOINT ["subnetcalc"]
CMD []
