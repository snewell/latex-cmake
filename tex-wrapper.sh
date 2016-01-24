#!/bin/sh

export TEXINPUTS="${TEXINPUTS}:$1"
export BIBINPUTS="${BIBINPUTS}:$1"

shift
exec $*
