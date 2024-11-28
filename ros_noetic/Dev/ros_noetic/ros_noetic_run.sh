#!/bin/bash

docker run -it --rm \
    --user=$(id -u $USER):$(id -g $USER) \
    --env="DISPLAY=$DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --net host \
    -v /home:/home \
    -v ~/Volumes:/home/usr/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    ros-noetic-container
