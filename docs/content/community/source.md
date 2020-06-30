---
title: Source
menu:
    main:
        parent: community
        weight: 3
description: How to compile the ChirpStack Gateway OS images yourself.
---

# ChirpStack Gateway OS source

The [Yocto](https://www.yoctoproject.org/) recipes can be found at:
[https://github.com/brocaar/chirpstack-gateway-os](https://github.com/brocaar/chirpstack-gateway-os).

## Building

The ChirpStack Gateway OS uses [Docker](https://www.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/). Make sure you have
these tools installed.


### Initial setup

Run the following command to set the `/build` folder permissions:

```bash
# on the host
docker-compose run --rm busybox

# within the container
chown 999:999 /build
```

### Building

Run the following command to setup the build environment:

```bash
# on the host
docker-compose run --rm yocto bash

# within the container

# update the submodules
make submodules

# initialize the yocto / openembedded build environment
source oe-init-build-env /build/ /chirpstack-gateway-os/bitbake/


# build the chirpstack-gateway-os-base image
bitbake chirpstack-gateway-os-base
```

#### Configuration

By default, Raspberry Pi3 is configured as the target platform. You need to
update the following configuration files to configure a different target:

* `/build/config/local.conf`
* `/build/config/bblayers.conf`
