#!/bin/bash -ex

docker create --name $CONTAINER_NAME malet/conduit-runner $COMMAND
# docker cp $MATERIAL_DIR

# shift 2 # Make $@ the rest of the arguments
# docker run -it malet/conduit-runner $@
