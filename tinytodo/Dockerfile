# we need gnu-recutils
FROM chko/recutils:1.8
ENV RECFILES /home/ehlo/recfiles
ENV TODOLIST $RECFILES/todo.rec
# base image uses a non-root user, but we need to do a few things as root first
ENV USER root
USER root
# bash isn't included in the base image
RUN apk add bash
# create scripts
RUN echo -e '#!/bin/bash\nrecsel -C -t Todo -R Id,Content "$TODOLIST"\n' > /usr/local/bin/lstodos
RUN chmod a+rx /usr/local/bin/lstodos
RUN ln -s /usr/local/bin/lstodos /usr/local/bin/lstodo
RUN echo -e '#!/bin/bash\nrecins -t Todo -f Content -v "$1" "$TODOLIST"\n' > /usr/local/bin/mktodo
RUN chmod a+rx /usr/local/bin/mktodo
RUN echo -e '#!/bin/bash\nrecdel -t Todo -e "Id = $1" "$TODOLIST"\n' > /usr/local/bin/rmtodo
RUN chmod a+rx /usr/local/bin/rmtodo
# recreate unprived user with shell set to bash + switch to it
RUN deluser ehlo
RUN adduser --shell /bin/bash --home /home/ehlo --disabled-password ehlo
ENV USER ehlo
USER ehlo
WORKDIR /home/ehlo
# prepopulate volume (contents will automatically get copied to new volume by Docker at its creation)
RUN mkdir /home/ehlo/recfiles
# work around bug - https://lists.gnu.org/archive/html/bug-recutils/2019-08/msg00001.html
ENV TMPDIR $RECFILES
RUN echo -e '%rec: Todo\n%key: Id\n%auto: Id\n%sort: Id\n%mandatory: Id Content' > $TODOLIST
VOLUME "/home/ehlo/recfiles"
CMD echo -e "usage: \n\nlstodos\nmktodo 'some text'\nrmtodo <id>\n"
