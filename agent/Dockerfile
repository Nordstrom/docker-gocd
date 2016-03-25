FROM nordstrom/java-jdk:8
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

ENV GOCD_VERSION=16.2.1-3027 \
    DOCKER_VERSION=1.9.1 \
    GO_VERSION=1.6

ADD gocd-gpg-key.asc /tmp/
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6 \
 && echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main" > /etc/apt/sources.list.d/brightbox_ruby.list \
 && apt-key add /tmp/gocd-gpg-key.asc \
 && echo "deb https://download.go.cd /" > /etc/apt/sources.list.d/gocd.list

RUN apt-get update -qy \
 && apt-get install -qy \
      git \
      awscli \
      ruby2.2 \
      ruby2.2-dev \
      go-agent=${GOCD_VERSION} \
      curl \
      build-essential

RUN mkdir /goroot /gopath \
 && curl -sL https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz | \
      tar xvzf - -C /goroot --strip-components=1
ENV GOROOT=/goroot GOPATH=/gopath
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

RUN curl -sLo /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} \
 && chmod 744 /usr/bin/docker

ADD log4j.properties /var/lib/go-agent/
ADD autoregister.properties /var/lib/go-agent/config/

# This is in place for enabling 'USER go' down the road
RUN chown go:go -R /var/lib/go-agent/* \
 && mkdir /var/lib/gems \
 && mkdir /src \
 && chown go:go -R /src \
 && chown go:go -R /var/lib/gems \
 && chown go:go -R /usr/local/bin \
 && rm /etc/default/go-agent

# USER go

ENV DAEMON=N \
    PRODUCTION_MODE=Y \
    GO_SERVER_PORT=8153 \
    AGENT_WORK_DIR=/var/lib/go-agent \
    USER=go

RUN echo "gem: --no-document" > $HOME/.gemrc \
 && gem install bundler

ENTRYPOINT ["/usr/share/go-agent/agent.sh"]
