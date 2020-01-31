![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/chko/swaks)   

## swaks

[swaks](http://jetmore.org/john/code/swaks/) smtp test tool on Alpine

### quickstart

```
docker run --rm -ti chko/swaks --to bridge@ncc1701d.subspace --from sarek@shikar.vulcan --auth LOGIN --auth-user bridge@ncc1701d.subspace --server smtp.ufp.subspace --header "Subject:first contact"
```
(note: with auth enabled, the password needs to be entered interactively -> use `-ti`).
