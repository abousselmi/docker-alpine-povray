FROM alpine:3.5

# install deps
RUN apk add --update --no-cache git \
                                coreutils \
                                build-base \
                                autoconf \
                                automake \
                                bash \
                                boost-dev \
                                zlib-dev \
                                libpng-dev \
                                jpeg-dev \
                                tiff-dev \
                                && rm -rf /var/cache/apk/*
# clone POV-Ray project
RUN git clone https://github.com/POV-Ray/povray.git

# run prebuild script
WORKDIR /povray/unix
RUN ./prebuild.sh

# compile and install POV-Ray
WORKDIR /povray
RUN ./configure COMPILED_BY="abousselmi"
RUN make
RUN make install
