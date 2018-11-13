FROM golang:1.11 as builder
WORKDIR /go/src/github.com/SergeyDz/go-slack-bot
COPY . .
# RUN go get  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app

FROM alpine
WORKDIR /app
RUN apk --no-cache add ca-certificates && update-ca-certificates
# ENV a="b"
COPY --from=builder /go/src/github.com/SergeyDz/go-slack-bot/app .
ENTRYPOINT ["./app"]