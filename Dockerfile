# syntax=docker/dockerfile:1

ARG HERMES_BASE_IMAGE=nousresearch/hermes-agent:latest
FROM ${HERMES_BASE_IMAGE}

USER root

ENV DEBIAN_FRONTEND=noninteractive

# Full TeX Live, media tools, and the native libraries required by Camofox.
# Hermes currently uses Debian 13, where several libraries use t64 package names.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        texlive-full \
        ffmpeg \
        libgtk-3-0t64 \
        libdbus-glib-1-2 \
        libx11-xcb1 \
        libxcb-shm0 \
        libxcb-dri3-0 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxrandr2 \
        libgbm1 \
        libasound2t64 \
        libatk1.0-0t64 \
        libatk-bridge2.0-0t64 \
        libcups2t64 \
        libdrm2 \
        libxkbcommon0 \
        libpango-1.0-0 \
        libcairo2 \
        libnss3 \
        libnspr4 \
        libxss1 \
        libxtst6 \
        libxshmfence1 \
        libglib2.0-0t64 \
        libfontconfig1 \
        ca-certificates \
        fonts-liberation \
        xauth \
        xvfb \
    && rm -rf /var/lib/apt/lists/*

# The base image includes uv. Installing from PyPI provides a newer yt-dlp
# than Debian's package, which matters as video platforms change frequently.
RUN uv pip install --system --no-cache-dir --upgrade yt-dlp

RUN latex --version \
    && pdflatex --version \
    && xelatex --version \
    && lualatex --version \
    && ffmpeg -version \
    && ffprobe -version \
    && yt-dlp --version

# Keep the upstream root startup context. Hermes' inherited /init entrypoint
# performs setup, then drops supervised services to the hermes user.
