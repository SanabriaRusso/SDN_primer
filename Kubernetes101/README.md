# Kubernetes 101
In this session we are going to go step-by-step doing the building of a Kubernetes cluster in bare metal.

## Installation using kubeadm
You can find these steps at the Kubernetes installation site, [official link].

### Important modifications
At one point you need to match the cgroupfs of Docker with that of Kubernetes. This can be done by looking at what Docker is using:

```bash
docker info | grep -i cgroup
```

And then, you can add this output to Environment="KUBELET_NETWORK_ARGS in the /etc/systemd/system/kubelet.service.d/10-kubeadm.conf:

```bash
--cgroup-driver=cgroupfs
```

## Initialise the Master and passing a Pod Network CIDR
Run the folling script at the Kubernetes master node:

```bash
swapoff

kubeadm init --pod-network-cidr=192.168.0.0/16
```

## Add worker nodes to the cluster
In this example, we have saved the scripts you need to execute in each of the worker nodes. You may find it in this same directory under the name join.nodes.

## ClusterRoleBinding to enable a free-access Dashboard
In this file we have written a ClusterRoleBinding for disabling authentication for the Dashboard. You might see it by:

```bash
kubectl get clusterrolebindings
```

And then once identified, you can erase it by:

```bash
kubect delete clusterrolebindings <name>
```

# Multiplatform Kubernetes Cluster (amd64/arm)
There is a problem when combining arm64 and amd architectures in your Kubernetes Cluster. Mainly, the kube-proxy pod sets the architecture type to that of the Master node. So, when joining an arm-node, like the Raspberry, you will get an error.

You can follow [the multiplaform cluster setup] link in order to solve this problem.


[official link]: https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

[the multiplaform cluster setup]: https://gist.github.com/squidpickles/dda268d9a444c600418da5e1641239af

