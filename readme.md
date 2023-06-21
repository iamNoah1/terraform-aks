# Terraform AKS 

This repo contains resources for deploying a Kubernetes cluster on Azure using Terraform. Additionally we create a network, a subnet and a public IP for the cluster.

## Prerequisites 
* Terraform CLI installed
* Azure CLI installed (and logged in)

## Deployment 
* `terraform init`
* Note that every variable in the [variables.tf](./variables.tf) file can be set by adding ` --var <var-name>=<value>` to the following commands. If not set, default values will be used. 
* `terraform plan` to see what would be done when applying 
* `terraform apply` to set up the infrastructure

## Connect to AKS 
* `echo "$(terraform output -raw kube_config)" > ./azurek8s` to create a k8s config 
* `export KUBECONFIG=./azurek8s` to set the k8s config 

## Clean Up 
* `terraform destroy`