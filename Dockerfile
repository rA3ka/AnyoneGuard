FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    iproute2 \
    iptables \
    iputils-ping \
    wireguard-tools \
    && echo "anon anon/terms boolean true" | debconf-set-selections \
    && . /etc/os-release \
    && curl -fsSL https://deb.en.anyone.tech/anon.asc -o /etc/apt/trusted.gpg.d/anon.asc \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/anon.asc] https://deb.en.anyone.tech anon-live-$VERSION_CODENAME main" > /etc/apt/sources.list.d/anon.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends anon \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
        /var/cache/apt/archives/* \
        /usr/share/doc/* \
        /usr/share/man/* \
        /usr/share/locale/* \
        /tmp/* \
        /var/tmp/*

RUN printf '#!/bin/bash\n\
chmod 600 /etc/wireguard/ag0.conf\n\
/usr/bin/wg-quick up ag0\n\
sleep 10\n\
exec /usr/bin/anon "$@"\n' > /start.sh && \
    chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
CMD ["-f", "/etc/anon/anonrc"]
