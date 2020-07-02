FROM python:buster

RUN apt-get update \
  && apt-get install -y wget apt-transport-https gpg \
  && rm -rf /var/lib/apt/lists/*

RUN echo "deb https://overviewer.org/debian ./" >> /etc/apt/sources.list

RUN wget https://overviewer.org/debian/overviewer.gpg.asc \
  && apt-key add overviewer.gpg.asc \
  && rm overviewer.gpg.asc

RUN  apt update \
  && apt install -y minecraft-overviewer \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash overviewer
USER overviewer
RUN mkdir /home/overviewer/worlds \
  && mkdir /home/overviewer/render

WORKDIR /home/overviewer

ADD config .

CMD ["render/overviewer.py", "--config=/home/overviewer/config"]

VOLUME ["/home/overviewer/worlds"]
VOLUME ["/home/overviewer/render"]
VOLUME ["/home/overviewer/textures"]

