#!/bin/bash
GO=$(firstword $(subst :, ,$(GOPATH)))
GOCOV=$(GO)/bin/gocov
GOCOVXML=$(GO)/bin/gocov-xml

# List of pkgs for the project
#PKGS=$(shell go list ./...)
PKGS=$(shell go list github.com/hyperledger/fabric/... | grep -v /vendor/ | grep -v /examples/)
# Coverage output: coverage/$PKG/coverage.out
COVPKGS=$(addsuffix /coverage.out,$(addprefix coverage/,$(PKGS)))

jenkins: coverage/cobertura-coverage.xml

coverage/cobertura-coverage.xml: coverage/all.out $(GOCOV) $(GOCOVXML)
        $(GOCOV) convert $< | $(GOCOVXML) >$@

coverage/all.out: $(COVPKGS)
        echo "mode: set" >$@
        grep -hv "mode: set" $(wildcard $^) >>$@

$(COVPKGS): .FORCE
        @ mkdir -p $(dir $@)
        @ go test -coverprofile $@ $(patsubst coverage/%/coverage.out,%,$@)

$(GOCOV):
        go get github.com/axw/gocov/gocov

$(GOCOVXML):
        go get github.com/AlekSi/gocov-xml

.FORCE:
.PHONY: jenkins
