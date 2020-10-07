image_tag=sengokyu/azure-pipelines-agent:latest

build:
	docker build -t $(image_tag) --force-rm .

shell:
	docker run -it --rm -e TOKEN=$(TOKEN) -e ORG=$(ORG) $(image_tag) /bin/bash

run:
	docker run -it --rm -e TOKEN=$(TOKEN) -e ORG=$(ORG) $(image_tag)

clean:
	docker rmi $(image_tag)

deploy-aci:
	az deployment group create \
		-g $(RG) \
		-p token=$(TOKEN) \
		-p org=$(ORG) \
		-f deploy-aci.json

