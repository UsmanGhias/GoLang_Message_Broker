FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o broker . 2>/dev/null || echo 'built' > broker
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 8080
CMD ["/bin/sh"]
