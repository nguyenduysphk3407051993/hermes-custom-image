# Hermes Custom Image

Custom Docker image derived from `nousresearch/hermes-agent:latest`.

Included tools:

- Full TeX Live distribution
- FFmpeg and FFprobe
- Current `yt-dlp` from PyPI
- Camofox native runtime dependencies
- Xvfb, Xauth, and Liberation fonts

## Build and run

Docker Compose builds the custom image directly from `Dockerfile`:

```bash
docker compose up -d --build
```

Copy `.env_example` to `.env`, then replace all placeholder credentials before
starting the service.

The base and output image names can be overridden when needed:

```bash
HERMES_BASE_IMAGE=nousresearch/hermes-agent:latest \
HERMES_IMAGE=hermes-agent-custom:latest \
docker compose build
```

`texlive-full` adds several gigabytes to the resulting image.
