FROM golang:alpine as builder

RUN apk update && apk add --no-cache git
WORKDIR /app

COPY main.go /app
COPY go.mod /app
# if you have dependencies/imports
# RUN go mod download

RUN go mod verify
RUN go build -o /app

FROM scratch
COPY --from=builder /app/codeedu /app/codeedu
ENTRYPOINT ["/app/codeedu"]