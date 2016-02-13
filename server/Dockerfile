FROM nordstrom/java:8
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

ENV GOCD_VERSION=16.1.0-2855 \
    DOCKER_VERSION=1.9.1

ADD gocd-gpg-key.asc /tmp/
RUN echo "deb https://download.go.cd /" > /etc/apt/sources.list.d/gocd.list \
 && apt-key add /tmp/gocd-gpg-key.asc

RUN apt-get update -qy \
 && apt-get install -qy \
      go-server=${GOCD_VERSION}

# ADD go-agent /etc/default

EXPOSE 8153 8154

ADD cruise-config.xml /etc/go/cruise-config.xml
RUN chown go /etc/go/cruise-config.xml

CMD /etc/init.d/go-server start && tail -F /var/log/go-server/go-server.log
