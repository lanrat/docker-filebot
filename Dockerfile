FROM dockerfile/java:oracle-java8
MAINTAINER Ian Foster <ian@vorsk.com>

# download and install filebot
RUN URL='http://sourceforge.net/projects/filebot/files/filebot/FileBot_4.5.3/filebot_4.5.3_amd64.deb/download'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

VOLUME /data

WORKDIR /data

ENTRYPOINT ["/usr/bin/filebot"]
