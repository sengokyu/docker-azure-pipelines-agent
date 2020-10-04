iamge_tag=sengokyu/azure-pipelines-agent:latest

build:
	docker build -t $(iamge_tag) --force-rm .

push:
	docker push $(iamge_tag)

shell:
	docker run -it --rm -e TOKEN=$(TOKEN) -e ORG=$(ORG) $(iamge_tag) /bin/bash

clean:
	docker rmi $(iamge_tag)
