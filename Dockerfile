FROM ubuntu as builder
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer-randomx
ENV     TZ=Europe/Berlin
RUN     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN     apt-get -y update
RUN		apt-get -y install git automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev zlib1g-dev make g++
RUN 	git clone https://github.com/CoreTex/cpuminer-randomx.git .
RUN	    ./build.sh

FROM ubuntu
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer-randomx
COPY --from=builder /docker-background-cpuminer-randomx .
RUN		    apt-get -y update
RUN         apt-get -y install curl libjansson4
ENTRYPOINT	["./cpuminer"]
