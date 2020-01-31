# docker build -t chko/swaks:latest -t chko/swaks:20190914.0 -f Dockerfile .
# docker run --rm -ti chko/swaks -t bridge@ncc1701d.subspace --from sarek@shikar.vulcan --auth LOGIN --auth-user bridge@ncc1701d.subspace --server smtp.ufp.subspace --header "Subject:first contact"
FROM alpine
RUN apk add perl curl
# v20190914.0 tag
RUN curl https://raw.githubusercontent.com/jetmore/swaks/9ea60128e73d8c73155bb18326655726d9211ba1/swaks -o /usr/local/bin/swaks && chmod a+rx /usr/local/bin/swaks
ENTRYPOINT ["/usr/local/bin/swaks"]
