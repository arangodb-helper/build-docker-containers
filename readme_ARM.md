# Steps to create ArangoDB DEB-packages for ARM
## Supported build platforms:
- Ubuntu 16 (xenial)
- Debian 8 (jessie)

## Supported target platforms (boards):
- Ubuntu 16 (xenial) on a ARM32 (armhf) board
- Ubuntu 16 (xenial) on a ARM64 (aarch64) board
- Debian 8 (jessie) on a ARM32 (armhf) board
- Debian 8 (jessie) on a ARM64 (aarch64) board

Note: ArangoDB will not runs on Raspbian image for RPi2 (with ARMv6 instruction set), <br>
because Googles V8 not supports this platform.<br>

## Build steps

1. Install git <br>
2. Install docker <br>
3. Clone ArangoDB-helper repo <br>
4. Create build docker images <br>
5. Clone ArangoDB repo <br>
6. Build ArangoDB packages <br>

### install git 
- sudo `apt install git` <br>

### install docker 
- use instruction from https://docs.docker.com/engine/installation/

### clone build repo 
- define a place for repo e.g. `/mnt/adb`
- clone repo with `git clone https://github.com/arangodb-helper/build-docker-containers`

### create build images
make a script or copy and paste in terminal:
- `cd build-docker-containers`
- `cd distros` <br>
`./buildContainers.sh adb debianjessiearmhfxc`  # for Debian on ARM32 <br>
`./buildContainers.sh adb debianjessieaarchxc`  # for Debian on ARM64 <br>
`./buildContainers.sh adb ubuntusixteenarmhfxc` # for Ubuntu on ARM32 <br>
`./buildContainers.sh adb ubuntusixteenaarchxc` # for Ubuntu on ARM64 <br>

after build you should check the created docker images with `docker images` <br>

### clone ArangoDB repo
cd `/mnt/adb`<br>
`git clone https://github.com/arangodb/arangodb`            # `all branches` OR <br>
`git clone https://github.com/arangodb/arangodb --depth=1`  # only curent `devel branch` ~ (10 time smaller size) <br>

### Build ArangoDB packages
you need makes two steps:<br>
- run docker<br>
- build ArangoDB<br>

### _step 1_: run docker
cd `/mnt/adb/arangodb`<br>
make a script or copy and paste in terminal:

#### for Debian on ARM32 
```
#!/bin/sh
docker run \
--volume /mnt/adb/arangodb:/build \
--volume /mnt/adb/arangodb/arm32d:/var/tmp \
-it debianjessiearmhfxc/build \
/bin/bash
```

#### for Debian on ARM64
```
#!/bin/sh
docker run \
--volume /mnt/adb/arangodb:/build \
--volume /mnt/adb/arangodb/arm64d:/var/tmp \
-it debianjessieaarchxc/build \
/bin/bash
```

#### for Ubuntu on ARM32 
```
#!/bin/sh
docker run \
--volume /mnt/adb/arangodb:/build \
--volume /mnt/adb/arangodb/arm32u:/var/tmp \
-it ubuntusixteenarmhfxc/build \
/bin/bash
```

#### for Ubuntu on ARM64 
```
#!/bin/sh
docker run \
--volume /mnt/adb/arangodb:/build \
--volume /mnt/adb/arangodb/arm64u:/var/tmp \
-it ubuntusixteenaarchxc/build \
/bin/bash
```

### _step 2_: build ArangoDB
in the container-console <br>
`cd /build`  # change to the build folder and run the build script:<br>
`./scripts/build-xc-deb.sh`    # ARM32 on Debian or Ubuntu <br>
`./scripts/build-xc64-deb.sh`  # ARM64 on Debian or Ubuntu <br>

### Created packages will be stored in
`arm64d` for Debian on aarch64 <br>
`arm64u` for Ubuntu on aarch64 <br>
`arm32d` for Debian on armhf (v7) <br>
`arm32u` for Ubuntu on armhf (v7) <br>

### Enter `exit` to leave the docker container and back to the host
