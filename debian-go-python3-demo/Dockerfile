FROM docker.io/library/debian:10
RUN apt-get -y update
RUN apt-get -y install golang python3.7 python3.7-dev pkg-config libpython3.7 libpython3.7-dev git
RUN ln -s /usr/lib/x86_64-linux-gnu/pkgconfig/python-3.7.pc /usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc
ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
COPY hello /hello
RUN cd /hello && go get . && go build -o /usr/local/bin/hello .
RUN hello
CMD hello


