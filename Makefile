VERSION    ?= dev
REPOSITORY ?= mobydig
IMAGE      ?= $(REPOSITORY):$(VERSION)

BUILD_OPTIONS = -t $(IMAGE)
BUILD_OPTIONS += --progress=plain

RUN_OPTIONS = --privileged 
RUN_OPTIONS += -v /var/run/docker.sock:/host/var/run/docker.sock 
RUN_OPTIONS += -v /dev:/host/dev 
RUN_OPTIONS += -v /proc:/host/proc:ro 
RUN_OPTIONS += -v /lib/modules:/host/lib/modules:ro 
RUN_OPTIONS += -v /usr:/host/usr:ro
RUN_OPTIONS += -v /usr/bin/docker:/usr/bin/docker:ro
RUN_OPTIONS += --net=host

default: csysdig

build:
	docker build $(BUILD_OPTIONS) .

bash:
	docker run -it --rm $(RUN_OPTIONS) $(IMAGE) bash

sysdig:
	docker run -it --rm $(RUN_OPTIONS) $(IMAGE) sysdig

csysdig:
	docker run -it --rm $(RUN_OPTIONS) $(IMAGE) csysdig -pc

clean:
	docker rmi $(IMAGE)
