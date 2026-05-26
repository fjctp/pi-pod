# pi-pod
A docker image for pi-coding-agent.

```bash
podman run --rm -it \
  --userns=keep-id \
  --user "$(id -u):$(id -g)" \
  -v ./config:/home/bun/.pi:rw \
  -v ./workdir:/home/bun/workdir:rw \
  ghcr.io/fjctp/pi-pod:latest
```
