FROM hrektts/texlive
MAINTAINER loopfz@gmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nkf bzip2 mftrace fontforge \
    && rm -rf /var/lib/apt/lists/*

ADD build-tile-font.sh /
RUN chmod +x /build-tile-font.sh &&  bash /build-tile-font.sh
