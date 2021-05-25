FROM golang:latest

RUN pwd
ADD main.go main.go
RUN go build -o app

FROM debian:buster-slim

COPY --from=0 /go/app /app

CMD /app
