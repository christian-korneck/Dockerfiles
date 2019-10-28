#!/bin/bash

# other user-overwriteable defaults
if [ -z "$VARIANT" ]; then VARIANT=bastet; fi
if [ "$VARIANT" == "bastet" ]; then CMD="/usr/games/bastet"; fi
if [ "$VARIANT" == "emacs" ]; then CMD="emacs -f tetris"; fi

# start main process
$CMD