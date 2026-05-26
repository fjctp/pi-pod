# pi-pod

A docker image for [pi-coding-agent](https://github.com/earendil-works/pi-coding-agent).

## Usage
Start a container with `ghcr.io/fjctp/pi-pod:latest` image.

```bash
podman run --rm -it \
  --userns=keep-id \
  --user "$(id -u):$(id -g)" \
  -v ./config:/home/bun/.pi:rw \
  -v ./workdir:/home/bun/workdir:rw \
  ghcr.io/fjctp/pi-pod:latest
```

> **Note on `--userns=keep-id` and `--user`:** By default, Podman remaps container UIDs to an unprivileged range in user namespaces. This causes mounted host files to appear with unexpected ownership inside the container. Using `--userns=keep-id` disables that remapping so UIDs stay consistent between host and container. Combined with `--user "$(id -u):$(id -g)"`, the process runs as your host user, ensuring the pi-coding-agent can read and write to `workdir` (and other mounts) without permission errors.

## Volumes

| Container | Purpose |
|---|---|
| `/home/bun/.pi` | Pi configuration and agent settings |
| `/home/bun/workdir` | Working directory for `pi` agent |

## Tools available

Minimal tools are included in the image:

- **bash** — Shell
- **git** — Version control
- **curl** — HTTP client
- **ripgrep** — Fast text search
- **fd** — Fast file finder
