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

[official link]: https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

