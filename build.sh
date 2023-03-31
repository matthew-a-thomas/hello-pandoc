#!/bin/bash

mkdir out

# https://hub.docker.com/r/pandoc/extra
docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/extra --defaults=defaults.yaml "$@"
#                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^ https://pandoc.org/MANUAL.html#defaults-files