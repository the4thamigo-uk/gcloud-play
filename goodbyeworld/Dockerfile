FROM golang:latest

RUN pwd
WORKDIR ./goodbyeworld
ADD * ./
RUN ls -la
RUN go build -o app

FROM debian:buster-slim

COPY --from=0 /go/goodbyeworld/app /app

CMD /app
