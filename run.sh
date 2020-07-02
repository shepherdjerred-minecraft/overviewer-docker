 docker run --rm \
 --mount "type=bind,target=/home/overviewer/worlds,source=/mnt/c/Users/Jerred/Downloads" \
 --mount "type=bind,target=/home/overviewer/textures,source=/mnt/c/Users/Jerred/Downloads/textures" \
 --mount "type=bind,target=/home/overviewer/render,source=/mnt/c/Users/Jerred/Downloads/render" \
 shepherdjerred/overviewer:latest
