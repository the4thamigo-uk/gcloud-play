FROM golang:latest

RUN pwd
WORKDIR ./helloworld
ADD helloworld/* ./
RUN ls -la
RUN go build -o app

FROM debian:buster-slim

COPY --from=0 /go/helloworld/app /app

CMD /app
