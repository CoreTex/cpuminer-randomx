FROM ubuntu as builder
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer-randomx
RUN     apt-get update
RUN		apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev zlib1g-dev make g++
RUN 	git clone https://github.com/CoreTex/cpuminer-randomx.git .
RUN	    ./build.sh

FROM ubuntu
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer-randomx
COPY --from=builder /docker-background-cpuminer-randomx .
RUN		apt-get install curl
ENTRYPOINT	["./cpuminer"]
