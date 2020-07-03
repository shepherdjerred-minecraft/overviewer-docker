#!/bin/bash
docker run --rm \
  --mount "type=bind,target=/home/overviewer/worlds,source=/server/data" \
  --mount "type=bind,target=/home/overviewer/render,source=/server/overviewer" \
  shepherdjerred/overviewer:latest
