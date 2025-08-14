# Build stage
FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o server .

# Runtime stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 9000
CMD ["./server"]
