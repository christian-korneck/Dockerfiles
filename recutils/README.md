![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/chko/recutils)   

## recutils

[gnu-recutils](https://www.gnu.org/software/recutils/) on Alpine  ([Docs](https://www.gnu.org/software/recutils/rec-mode-manual/recutils.html))

### quickstart

```
docker run --rm -ti chko/recutils recsel --help
```

### examples

#### list all utils

```
$ docker run --rm -ti chko/recutils
available utils:
----------------
rec2csv  recdel   recfix   recfmt   recinf   recins   recsel   recset
```

#### pass recfile from host as volume

create dir/file on host:
```
mkdir $HOME/recfiles
echo '%rec: Item' > $HOME/recfiles/test.rec
```

write:
```
docker run --rm -ti -v $HOME/recfiles:/home/ehlo/recfiles chko/recutils /bin/sh -c 'cd /home/ehlo/recfiles && TMPDIR=. recins -t Item -f Content -v "test record" test.rec'
```

read:
```
docker run --rm -ti -v $HOME/recfiles:/home/ehlo/recfiles chko/recutils /bin/sh -c 'cd /home/ehlo/recfiles && TMPDIR=. recsel -t Item test.rec'
```

(Due to a [bug](https://lists.gnu.org/archive/html/bug-recutils/2019-08/msg00001.html) `TMPDIR` needs to point to the same volume as the recfile for writing)