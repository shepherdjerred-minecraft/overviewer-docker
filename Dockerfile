FROM python:alpine

RUN echo "deb https://overviewer.org/debian ./" >> /etc/apt/sources.list

RUN apt update \
  && apt install -y wget apt-transport-https \
  && rm -rf /var/lib/apt/lists/*

RUN wget -O - https://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -

RUN  apt update \
  && apt install -y minecraft-overviewer \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash overviewer
USER overviewer
RUN mkdir /home/overviewer \
  && /home/overviewer/worlds \
  && /home/overviewer/render
WORKDIR /home/overviewer

ADD config .

CMD ["render/overviewer.py", "/home/overviewer/worlds", "/home/overviewer/render", "--config=/home/overviewer/config"]

VOLUME ["/home/overviewer/worlds"]
VOLUME ["/home/overviewer/render"]
