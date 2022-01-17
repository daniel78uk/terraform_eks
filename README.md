# Teraform EKS

Those scripts are taken from https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster

## Setup

First type the following:

```
make
```

This will install all required libs.

Then create your AWS key.

```
aws configure
```


## Create cluster

Type:

```
cd kubernetes
terraform init
terraform apply
## on completion
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

Also look in the output for the domain: `cluster_endpoint`.

## Helm

Go inside each repo and run

```
terraform init
terraform apply
```

Charts can be customizeed with the values.yaml.

The configuration is taken from https://learn.hashicorp.com/tutorials/terraform/helm-provider?in=terraform/kubernetes.