FROM golang:1.10 as builder

COPY . $GOPATH/src/gofunky/envtpl/
WORKDIR $GOPATH/src/gofunky/envtpl/

ENV GOOS=linux
ENV GOARCH=amd64

RUN go get -v -d
RUN go build -v -o /go/bin/envtpl

FROM gofunky/git:stable

COPY --from=builder /go/bin/envtpl /usr/local/bin/envtpl
RUN chmod +x /usr/local/bin/envtpl

ENTRYPOINT ["/usr/local/bin/envtpl"]
