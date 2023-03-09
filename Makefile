CWD = $(shell pwd)

.PHONY: help
.ONESHELL:
help: ## Show these help instructions
	@sed -rn 's/^([\.0-9a-zA-Z_-]+):.*?## (.*)$$/"\1" "\2"/p' < $(MAKEFILE_LIST) | xargs printf "make %-30s# %s\n"

setup_rmlmapper_6.1.3: ## Install this specific version of RMLMapper
	wget -c -P ./target/tools/rmlmapper/ https://github.com/RMLio/rmlmapper-java/releases/download/v6.1.3/rmlmapper-6.1.3-r367-all.jar

setup_carml_1.1.9: ## Install this specific version of carml
	wget -c -P ./target/tools/carml/ https://github.com/carml/carml-jar/releases/download/carml-jar-1.1.0/carml-jar-jena-1.1.0-0.4.6.jar

setup_sdm-rdfizer_latest:   ## Install the latest version of SDM RDFizer via pip
	pip install rdfizer

setup_morph-kgc_latest: ## Install the latest version of Morph-KGC via pip
	pip install morph-kgc

