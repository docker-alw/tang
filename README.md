# Docker Tang

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/docker-alw/tang/main.svg)](https://results.pre-commit.ci/latest/github/docker-alw/tang/main)
[![dependabot update](https://github.com/docker-alw/tang/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/docker-alw/tang/actions/workflows/dependabot/dependabot-updates)
[![dependabot validate](https://github.com/docker-alw/tang/actions/workflows/dependabot_validate.yml/badge.svg)](https://github.com/docker-alw/tang/actions/workflows/dependabot_validate.yml)
[![Build Main Image](https://github.com/docker-alw/tang/actions/workflows/build_image.yml/badge.svg)](https://github.com/docker-alw/tang/actions/workflows/build_image.yml)

Docker image based on alpine running [Tang](https://github.com/latchset/tang).

## Run

To run this container you can use following example command:

```bash
docker run --name "tang" --init -v "/path/to/tang-database/:/var/db/tang" -p 9090:9090 "ghcr.io/docker-alw/tang"
```

Hint: `--init` is required for tang to receive kill-signals correctly.

By default the container runs Tang in listen mode with port 9090 and databases stored in `/var/db/tang`.

To overwrite these setting, define a different entrypoint like this:

```bash
docker run --name "tang" --init -v "/path/to/tang-database/:/tang" -p 8080:8080 "ghcr.io/docker-alw/tang" --listen --port 8080 /tang
```

For an overview of options run:

```bash
docker run --rm "ghcr.io/docker-alw/tang" --help
```
