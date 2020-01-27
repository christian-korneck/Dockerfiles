# docker build -t chko/recutils .
# docker run --rm -ti chko/recutils recsel --help
# docker run --rm -ti -v $HOME/recfiles:/home/ehlo/recfiles chko/recutils /bin/sh -c 'cd /home/ehlo/recfiles && TMPDIR=. recins -t Item -f Content -v "test record" test.rec'

FROM alpine AS builder
WORKDIR /root
RUN apk add alpine-sdk
RUN wget http://ftp.gnu.org/gnu/recutils/recutils-1.8.tar.gz
RUN tar xf recutils-1.8.tar.gz
WORKDIR /root/recutils-1.8
RUN ./configure --prefix=/usr/local
RUN make
RUN mkdir /root/dist
RUN make install DESTDIR=$HOME/dist PREFIX=/usr/local
WORKDIR /root
RUN tar -cf dist.tar dist

FROM alpine
WORKDIR /root
COPY --from=builder /root/dist.tar .
RUN tar xf dist.tar --directory / --strip 1 && rm -f dist.tar
#switching to an unprived user
RUN chmod a+w /tmp
RUN adduser --shell /bin/sh --home /home/ehlo --disabled-password ehlo
ENV USER ehlo
WORKDIR /home/ehlo
CMD cd /usr/local/bin && echo 'available utils:' && echo '----------------' && ls rec*