FROM java:openjdk-8-jre
MAINTAINER Ian Foster <ian@vorsk.com>

# install mediainfo
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mediainfo && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

# download and install filebot
RUN URL='https://www.filebot.net/download.php?mode=s&type=deb&arch=amd64'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

VOLUME /data

WORKDIR /data

ENTRYPOINT ["/usr/bin/filebot"]
