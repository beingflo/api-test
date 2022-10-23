# Builder stage
FROM rust:1.64.0 AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

# Runtime stage
FROM rust:1.64.0-slim AS runtime
WORKDIR /app
# Copy the compiled binary from the builder environment # to our runtime environment
COPY --from=builder /app/target/release/api-test api-test
ENTRYPOINT ["./api-test"]