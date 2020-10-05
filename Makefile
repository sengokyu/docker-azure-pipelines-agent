image_tag=sengokyu/azure-pipelines-agent:latest

build:
	docker build -t $(image_tag) --force-rm .

push:
	docker push $(image_tag)

shell:
	docker run -it --rm -e TOKEN=$(TOKEN) -e ORG=$(ORG) $(image_tag) /bin/bash

clean:
	docker rmi $(image_tag)

create:
	az container create -g $(RG) --name azure-pipelines-agent --image $(image_tag) --cpu 2 --memory 2 --environment-variables TOKEN=$(TOKEN) ORG=$(ORG)
