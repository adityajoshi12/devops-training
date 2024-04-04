# Assignment questions


**Pods:**

1. **Create a Pod with two containers, one running Nginx and the other a custom application image pulled from a private registry.**
2. **Define a Pod with a liveness probe that checks if the Nginx container is responding on port 80.**
3. **Configure a Pod to mount a ConfigMap as a volume and access the data within the containers.**
4. **Set resource requests and limits for CPU and memory on a container within a Pod.**
5. **Expose a Pod's container port using a service of type NodePort.**

**Nodes:**

1. **List all nodes in the cluster and display their status, roles, and labels.**
2. **Drain a node to evict all Pods safely before performing maintenance.**
3. **Add a label to a specific node to schedule Pods with specific requirements.**
4. **Describe a node to view its detailed information, including allocatable resources and conditions.**
5. **Taint a node to prevent scheduling of Pods that do not tolerate the taint.**

**Deployments:**

1. **Create a Deployment for an Nginx application with 3 replicas and expose it as a service.**
2. **Update the image version of a container in a Deployment using a rolling update strategy.**
3. **Scale a Deployment to 5 replicas using the kubectl scale command.**
4. **Rollback a Deployment to a previous revision if a new update causes issues.**
5. **Perform a canary deployment for a new version of your application alongside the current version.**


**Tools and Tips:**

* Practice using `kubectl` commands for managing Pods, nodes, and deployments.
* Understand YAML syntax for defining Kubernetes resources.
* Explore the Kubernetes documentation for detailed information on each concept.
