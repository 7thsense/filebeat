LATEST_IMAGE:="7thsense/filebeat:latest"
PARAMS:="filebeat"
IMAGE:="7thsense/filebeat:1.1.1"

build: Dockerfile bootstrap.sh docker-entrypoint.sh 
	docker build .

tag-latest: build
	docker build -t $(IMAGE) -t $(LATEST_IMAGE) .

publish: tag-latest
	docker push $(IMAGE)
	docker push $(LATEST_IMAGE)

start: tag-latest
	docker run $(PARAMS) --detach $(LATEST_IMAGE)

run: tag-latest
	docker run $(PARAMS) -ti $(LATEST_IMAGE)
