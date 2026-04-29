FROM golang:1.26.2

ENV CGO_ENABLED=1 \
    GO111MODULE=on \
    GOPATH=/go \
    GOBIN=/usr/local/bin \
    GOMODCACHE=/go/pkg/mod \
    GOCACHE=/go/cache/build \
    PATH="/usr/local/bin:/go/bin:${PATH}"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      wget \
      git \
      graphviz

RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/go-task/task/v3/cmd/task@latest
RUN go install github.com/google/pprof@latest