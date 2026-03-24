FROM debian:bookworm

COPY image-assets/.wine32 /config/.wine32
COPY image-assets/home /config/home

ENV HOME=/config/home
ENV DEBIAN_FRONTEND=noninteractive
ENV WINEARCH=win32
ENV WINEPREFIX=/config/.wine32
ENV DISPLAY=:0
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN sed -i 's/Components: main/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      locales \
      wget \
      curl \
      ca-certificates \
      unzip \
      p7zip-full \
      cabextract \
      xvfb \
      x11vnc \
      fluxbox \
      novnc \
      websockify \
      xterm \
      procps \
      netcat-openbsd \
      winbind \
      wine \
      wine32 \
      winetricks && \
    sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /config /output /opt/eac /config/home

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY scripts/setup-prefix.sh /usr/local/bin/setup-prefix.sh
COPY scripts/run-desktop.sh /usr/local/bin/run-desktop.sh
COPY scripts/healthcheck.sh /usr/local/bin/healthcheck.sh

COPY web/eac.html /usr/share/novnc/eac.html

RUN chmod +x /usr/local/bin/*.sh

EXPOSE 8080 5900

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD /usr/local/bin/healthcheck.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
