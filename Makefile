image_tag=sengokyu/azure-pipelines-agent:latest

build:
	docker build -t $(image_tag) --force-rm .

push:
	docker push $(image_tag)

shell:
	docker run -it --rm -e TOKEN=$(TOKEN) -e ORG=$(ORG) $(image_tag) /bin/bash

clean:
	docker rmi $(image_tag)

deploy:
	az deployment group create \
		-g $(RG) \
		-p token=$(TOKEN) \
		-p org=$(ORG) \
		-f deploy-aci.json

