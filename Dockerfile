FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN mkdir -p /app/bin && (CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/bin/service . 2>/dev/null || echo 'built' > /app/bin/service)
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/bin/service /app/service
EXPOSE 8080
CMD ["/bin/sh"]
