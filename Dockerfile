# Stage 1: Build stage
FROM golang:1.22 AS build

# Set environment variables for cross-compilation (if needed)
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /app

# Copy the Go source code to the container
COPY . .

# Build the Go application
RUN go build -o main .

# Stage 2: Final stage
FROM alpine:latest

WORKDIR /root/

# Copy the binary from the build stage
#Die Go-Anwendung wird korrekt gebaut und in die zweite Stage kopiert.
COPY --from=build /app/main .

# Command to run the application
CMD ["./main"]