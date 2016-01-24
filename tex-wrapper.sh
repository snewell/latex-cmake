#!/bin/sh

export TEXINPUTS="${TEXINPUTS}:$1:$1/sty"
export BIBINPUTS="${BIBINPUTS}:$1"

shift
exec $*
