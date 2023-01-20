FROM rust as builder

ADD . /hound
WORKDIR /hound/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN cargo fuzz build decode_full

FROM ubuntu:20.04

COPY --from=builder /hound/fuzz/target/x86_64-unknown-linux-gnu/release/decode_full /