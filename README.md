# Hermes Custom Image

Custom Docker image derived from `nousresearch/hermes-agent:latest`.

Included tools:

- Full TeX Live distribution
- FFmpeg and FFprobe
- Current `yt-dlp` from PyPI
- Camofox native runtime dependencies
- Xvfb, Xauth, and Liberation fonts

## Build and run

The existing `docker-compose.yml` uses the upstream image name. Build the
custom image with that same local tag, then prevent Compose from pulling over
it:

```bash
docker build --pull -t nousresearch/hermes-agent:latest .
docker compose up -d --force-recreate --pull never
```

Copy `.env_example` to `.env`, then replace all placeholder credentials before
starting the service.

`texlive-full` adds several gigabytes to the resulting image.
