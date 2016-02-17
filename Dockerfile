FROM fedora:23
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
ENV VERSION=v6
RUN dnf install -y git golang && \
  mkdir -p /go/src/github.com/gliderlabs/ && \
  git clone https://github.com/gliderlabs/registrator.git /go/src/github.com/gliderlabs/registrator && \
  cd /go/src/github.com/gliderlabs/registrator && \
  git checkout ${VERSION} && \
  export GOPATH=/go && go get && go build -ldflags "-X main.Version $(cat VERSION)" -o /bin/registrator && \
  rm -rf /go && \
  dnf remove -y git golang && \
  dnf clean all

CMD ["/bin/registrator", "-ttl", "10", "-ttl-refresh", "5", "-resync", "120" ,"consul://consul.service.consul:8500/"]
