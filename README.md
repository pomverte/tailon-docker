# Tailon container image

![](https://img.shields.io/badge/Tailon-1.4.2-orange)

https://tailon.readthedocs.io

## Configuration

tailon-config.yml
```yaml
---
bind: 0.0.0.0:80             # address and port to bind on
allow-transfers: true        # allow log file downloads
follow-names: false          # allow tailing of not-yet-existent files
relative-root: ''            # web app root path (default: '')
commands: [tail, grep, awk]  # allowed commands
tail-lines: 100              # number of lines to tail initially
wrap-lines: false            # initial line-wrapping state

files:
  - '/logs/*.log'            # all files in this directory

http-auth: basic             # enable authentication (optional)
users:                       # password access (optional)
  username: CHANGEME_password
```

## Start Service

IMPORTANT: add a dummy file in the log directory otherwise Tailon won't start !

### Docker CLI

```
docker container run -d -it -p 80:80 \
    -v /path/to/tailon-config.yml:/etc/tailon/tailon-config.yml \
    -v /path/to/logs:/logs \
    --name tailonme \
    vietnem/tailon:latest
```

### Docker Compose

docker-compose.yml
```yaml
---
version: '3'
services:
  tailon:
    image: vietnem/tailon:latest
    container_name: tailon
    ports:
      - "80:80"
    volumes:
      - /path/to/logs:/logs:ro
      - /path/to/tailon-config.yml:/etc/tailon/tailon-config.yml
```

```
docker-compose up -d
```
