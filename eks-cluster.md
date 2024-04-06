# EKS 

EKS provides a managed and scalable platform for running Kubernetes workloads. It offers benefits such as reduced operational overhead, seamless integration with other AWS services, and simplified management through the eksctl command-line tool. These advantages make EKS a powerful option for deploying containerized applications on AWS.
Let’s look at some useful commands for eksctl, which is a command-line tool used for managing EKS clusters:

### Install eksctl
https://eksctl.io/installation/

### Cluster Management

* **Creating a cluster:**
 `eksctl create cluster --name <cluster_name> --region us-west-2 --node-type t2.micro --nodes 3` 
* **Deleting a cluster:** 
 `eksctl delete cluster --name=<cluster_name>`
* **Updating a cluster:**
 `eksctl upgrade cluster --name=<cluster_name> --version=<new_version>`
* **Scaling nodegroups:**
 `eksctl scale nodegroup --cluster=<cluster_name> --name=<nodegroup_name> --nodes=<desired_number>`
* **Listing clusters:**
 `eksctl get cluster`



```bash
eksctl create cluster --name my-eks-cluster --region us-west-2 --node-type t2.micro --nodes 3
eksctl delete cluster --name my-eks-cluster --region us-west-2
eksctl scale nodegroup --cluster my-eks-cluster --nodes 5 --name my-nodegroup

eksctl update cluster --name my-eks-cluster --region us-west-2 --kubernetes-version 1.29
eksctl get cluster --name my-eks-cluster --region us-west-2
```
