FROM ubuntu:18.04

ENV TZ America/New_York
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :99
ENV RESOLUTION 1920x1080x24

RUN \
    adduser --system --home /home/testuser \
    --ingroup nogroup --disabled-password --shell /bin/bash testuser && \
    mkdir -p /home/testuser/Downloads && \
    chown testuser:nogroup /home/testuser/Downloads && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget \
    openjdk-8-jdk \
    maven \
    git \
    xvfb \
    gnupg2 \
    x11vnc \
    fluxbox \
    feh \
    eterm \
    xfonts-base && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends google-chrome-stable && \ 
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

EXPOSE 5900

COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

USER testuser

ENTRYPOINT ["sh", "/opt/entrypoint.sh"]