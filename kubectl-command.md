

## Basic kubectl commands:

### Nodes:

* **`kubectl get nodes`**: This command lists all nodes in the cluster. You can also use flags like `-o wide` for more detailed information or `-l key=value` to filter nodes based on labels.
* **`kubectl describe node <node-name>`**: Provides detailed information about a specific node, including its status, resources, labels, and pods running on it.
* **`kubectl cordon <node-name>`**: Marks a node as unschedulable, preventing new pods from being assigned to it. This is useful for maintenance or draining a node before decommissioning.
* **`kubectl uncordon <node-name>`**: Makes a node schedulable again, allowing new pods to be assigned to it.

### Pods:

* **`kubectl get pods`**: Lists all pods in the current namespace. You can use flags like `-o wide` for more information, `-n <namespace>` to specify a different namespace, or `-l key=value` to filter pods based on labels.
* **`kubectl describe pod <pod-name>`**: Provides detailed information about a specific pod, including its status, container images, resource usage, and events.
* **`kubectl create -f <filename>`**: Creates pods and other Kubernetes objects from a YAML or JSON file.
* **`kubectl delete pod <pod-name>`**: Deletes a specific pod.
* **`kubectl logs <pod-name>`**: Displays the logs of a specific pod. You can also specify a container name with `-c <container-name>` if the pod has multiple containers.
* **`kubectl exec -it <pod-name> -- <command>`**: Executes a command inside a running container in a pod.

**1. Listing pods:**

* `kubectl get pods`: This command lists all pods in the current namespace.
* `kubectl get pods -n <namespace>`: This command lists all pods in a specific namespace.
* `kubectl get pods -o wide`: This command provides additional information about pods, such as their IP addresses and node names.

**2. Creating pods:**

* `kubectl create -f <filename.yaml>`: This command creates a pod based on the definition in a YAML file.
* `kubectl run <pod-name> --image=<image-name>`: This command creates a simple pod using a specific image.

**3. Describing pods:**

* `kubectl describe pod <pod-name>`: This command provides detailed information about a specific pod, including its status, events, and resource usage.

**4. Deleting pods:**

* `kubectl delete pod <pod-name>`: This command deletes a specific pod.
* `kubectl delete -f <filename.yaml>`: This command deletes pods defined in a YAML file.

**5. Executing commands in pods:**

* `kubectl exec -it <pod-name> -- <command>`: This command executes a command inside a running container within the pod.

**6. Viewing logs from pods:**

* `kubectl logs <pod-name>`: This command displays the logs from a specific pod.
* `kubectl logs -f <pod-name>`: This command streams the logs from a specific pod.

**7. Scaling pods:**

* `kubectl scale deployment <deployment-name> --replicas=<number>`: This command scales a deployment to a specific number of replicas (pods).

**Additional notes:**

* You can use flags like `-l` with `kubectl get pods` to filter pods based on labels.
* You can combine commands with pipes to achieve more complex tasks. For example, `kubectl get pods | grep <keyword>` will list pods whose names contain the specified keyword.


**Additional useful commands:**

* **`kubectl get all`**: Provides a quick overview of all resources in the current namespace, including pods, services, deployments, etc.
* **`kubectl explain <resource-type>`**: Displays detailed information about a specific Kubernetes resource type, including its fields and sub-resources.
* **`kubectl api-resources`**: Lists all available API resources in the Kubernetes cluster.

**Remember:**

* You can use the `--help` flag with any kubectl command to get detailed information about its usage and available flags.
* You can combine multiple flags to filter and format the output of kubectl commands.
* kubectl commands operate on the current namespace by default. Use the `-n <namespace>` flag to specify a different namespace.

These are just some of the basic kubectl commands for managing nodes and pods. As you become more familiar with Kubernetes, you can explore more advanced commands and features. For more information and advanced commands, refer to the official Kubernetes documentation: https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

