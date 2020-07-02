FROM debian:latest


RUN apt-get update \
  && apt-get install -y git unzip build-essential python3-pil python3-dev python3-numpy \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash overviewer
USER overviewer
RUN mkdir /home/overviewer/worlds \
  && mkdir /home/overviewer/render \
  && mkdir /home/overviewer/build \
  && mkdir /home/overviewer/textures

WORKDIR /home/overviewer/build
RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git

WORKDIR /home/overviewer/build/Minecraft-Overviewer
RUN python3 setup.py build

WORKDIR /home/overviewer
ADD config .

WORKDIR /home/overviewer/textures
ARG MINECRAFT_VERSION=1.16.1
ADD --chown=overviewer:overviewer https://overviewer.org/textures/$MINECRAFT_VERSION client.zip
RUN unzip client.zip "assets/*"

WORKDIR /home/overviewer/build/Minecraft-Overviewer
CMD ["./overviewer.py", "--config=/home/overviewer/config"]

VOLUME ["/home/overviewer/worlds"]
VOLUME ["/home/overviewer/render"]
VOLUME ["/home/overviewer/textures"]

