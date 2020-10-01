# mobydig
Image to run Sysdig on Docker Desktop for mac (but not only, it should work on a docker engine on a linux host)

# Note!

This updated image is forked from: https://github.com/fdebonneval/mobydig

# Why ?
Why a particular image for Docker Desktop?

Sysdig provides a Docker image to run sysdig/csysdig on Docker but on a Linux host. We can grab the [linuxkit kernel](https://hub.docker.com/r/docker/for-desktop-kernel) that Docker Desktop uses and build the sysdig eBPF probe.

# Get it, build it

    # git clone https://github.com/outstand/mobydig
    # cd mobydig
    # make build

After the build, the image is published in your local registry with the name `mobydig:dev`.
You can choose the image tag with the VERSION variable in the Makefile.

# And run it
To run csysdig, the great htop like ncurses tool, just use

    # make csysdig

To run sysdig, use

    # make sysdig

# References
* Thanks to @fdebonneval for the original image!
