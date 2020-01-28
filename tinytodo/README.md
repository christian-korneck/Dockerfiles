![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/chko/tinytodo)   

## tinytodo

[tinytodo](http://github.com/christian-korneck/tinytodo) (*a most minimal todo list in the shell*) on Alpine

### quickstart

The todolist recfile is by default stored in a Docker volume. First we create a dummy container for the volume (make sure to not delete this container):

```
docker run --name todo_volume -ti chko/tinytodo lstodos
```

We can now start temporary containers to work with the file from the volume.

Create item:
```
docker run --rm -ti --volumes-from todo_volume chko/tinytodo mktodo 'my first todo'
```

List items:
```
docker run --rm -ti --volumes-from todo_volume chko/tinytodo lstodos
```

Delete items:
```
docker run --rm -ti --volumes-from todo chko/tinytodo rmtodo <id>
```



