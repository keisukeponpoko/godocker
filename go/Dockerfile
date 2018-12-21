FROM golang:1.11.1

WORKDIR /go/src/app
ADD . /go/src/app

ENV GO111MODULE=on

EXPOSE 8080

CMD ["go", "run", "main.go"]
