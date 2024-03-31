## Kubernetes Pods: Short Notes

**What is a Pod?**

* A Pod is the smallest deployable unit in Kubernetes. 
* It represents a single instance of a running process in the cluster. 
* It encapsulates one or more containers, along with shared storage and network resources.

**Key characteristics:**

* **Ephemeral:** Pods are created and destroyed dynamically. 
* **Shared resources:** Containers within a Pod share the same network namespace and can communicate with each other via localhost. 
* **Single instance:** A Pod typically represents a single instance of an application. 
* **Managed by controllers:** Controllers like Deployment or ReplicaSet manage the lifecycle of Pods.

**Pod components:**

* **Containers:** The core of a Pod, running the application processes. 
* **Volumes:** Shared storage accessible by all containers in the Pod. 
* **Network namespace:** Defines the network environment for the Pod. 
* **Pod metadata:** Includes labels, annotations, and other information about the Pod.

**Pod lifecycle:**

* **Pending:** Pod is created but not yet scheduled on a node. 
* **Running:** Pod is scheduled on a node and containers are running. 
* **Succeeded:** All containers in the Pod have successfully terminated. 
* **Failed:** One or more containers in the Pod have failed. 
* **Unknown:** The state of the Pod cannot be determined.

**Use cases:**

* Running single-container applications. 
* Running tightly coupled multi-container applications. 
* Providing a shared context for containers. 

**Note:** Pods are rarely created directly. Controllers are typically used to manage and scale Pods.
