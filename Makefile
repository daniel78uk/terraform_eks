SHELL = /bin/sh
SERVICE=eks-cluster-platform

.PHONY: install install_eks install_eks_metrics install_eks_dashboard

all: install

install:
	brew install tfenv
	tfenv install latest
	tfenv use latest
	brew install kubernetes-cli

install_eks:
	cd kubernetes
	terraform init
	terraform apply
	aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

install_eks_metrics:
	cd kubernetes
	wget -O v0.3.6.tar.gz https://codeload.github.com/kubernetes-sigs/metrics-server/tar.gz/v0.3.6 && tar -xzf v0.3.6.tar.gz
	kubectl apply -f metrics-server-0.3.6/deploy/1.8+/

install_eks_dashboard:
	cd kubernetes
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
