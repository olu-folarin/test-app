# Multi-stage Dockerfile for Go Microservice

# Builder stage
FROM golang:1.18-alpine AS builder
WORKDIR /app

# Cache module downloads
COPY go.mod ./
# Uncomment the following line if you have a go.sum file
# COPY go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o microservice

# Final stage
FROM alpine:latest
WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/microservice .

# Expose the app port
EXPOSE 8080

# Command to run the binary
CMD ["./microservice"]
