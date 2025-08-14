# Build stage
FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o server .

# Runtime stage
FROM golang:alpine
WORKDIR /app
COPY --from=builder /app/server .
COPY ./static ./static
COPY ./templates ./templates
EXPOSE 8080
CMD ["./server"]
