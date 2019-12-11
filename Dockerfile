FROM golang:1.11.5 as builder

COPY . $GOPATH/src/gofunky/envtpl/
WORKDIR $GOPATH/src/gofunky/envtpl/

ENV GOOS=linux
ENV GOARCH=amd64

RUN go get -v -d
RUN go build -v -o /go/bin/envtpl

FROM gofunky/git:2.18.2
LABEL maintainer="mat@fax.fyi"

COPY --from=builder /go/bin/envtpl /usr/local/bin/envtpl
RUN chmod +x /usr/local/bin/envtpl

ENTRYPOINT ["/usr/local/bin/envtpl"]

ARG VERSION=latest
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/gofunky/envtpl" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
