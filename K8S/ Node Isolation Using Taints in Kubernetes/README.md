# ☸️ Lab 19: Node Isolation Using Taints in Kubernetes (Kubeadm)

This lab demonstrates how to create a **3-node Kubernetes cluster using kubeadm** and isolate workloads using **taints**. Each node is tainted with a different role to restrict pod scheduling unless a matching toleration is provided.

---

## 📖 Lab Objective

The purpose of this lab is to:

- Learn how to set up a Kubernetes cluster manually using `kubeadm`
- Apply **taints** to nodes to isolate workloads (master / app / database)
- Understand how **taints and tolerations** affect pod scheduling

This is a core DevOps concept used in real production-grade Kubernetes clusters for security, performance, and control.

---

## 🧰 Prerequisites

Perform the following steps on **all 3 nodes** (1 master, 2 workers):

- Ubuntu 20.04 or 22.04
- Minimum 2 CPUs and 2 GB RAM
- sudo/root access
- Internet access
- Hostnames set properly (e.g. `master`, `worker1`, `worker2`)

---

## 🔧 Step 1:  Install Docker on all Machine

```bash
sudo apt update 
# Install a prerequisite package that allows apt to utilize HTTPS:
sudo apt-get install apt-transport-https ca-certificates curl gpg
sudo install -m 0755 -d /etc/apt/keyrings
# Add GPG key for the official Docker repo to the Ubuntu system:
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc 
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the Docker repo to APT sources:
 echo \ 
  "deb [arch=$(dpkg --print-architecture) signed-
by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Update the database with the Docker packages from the added repo:
sudo apt-get update
# Install Docker software:
sudo apt install -y containerd.io docker-ce docker-ce-cli 
# Docker should now be installed, the daemon started, and the process enabled to start on boot. To verify:
sudo systemctl status docker
# Make the docker enable to start automatic when reboot the machine:
sudo systemctl enable docker 
sudo systemctl daemon-reload 
sudo systemctl enable docker 
sudo systemctl enable --now containerd
# Add user to docker Groups:
sudo usermod -aG docker ${USER} 
```

## 🛠️ Step 2: Install Install CNI Plugin
```
wget 
https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz 
sudo mkdir -p /opt/cni/bin 
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.0.tgz
sudo systemctl restart containerd 
sudo systemctl enable containerd 
```
## Step 3: swap & selinux
```
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab 
sudo swapoff -a 
## Install selinux (in all Machine):
sudo apt install selinux-utils 
# Disable selinux (in all Machine):
setenforce 0 
```
## Step 4: Enable IP forwarding temporarily:
```
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
# Enable IP forwarding permanently:
#  Apply the changes:
sudo sysctl -p 
# Validate Containerd
sudo crictl info 
# Validate Containerd
cat /proc/sys/net/ipv4/ip_forward
# Give a unique hostname for all machines:
sudo hostnamectl set-hostname master 
sudo hostnamectl set-hostname node1 
sudo hostnamectl set-hostname node2 
```
### 🚫 Restart All Machines.

## step 5: Configure Hostname
Set the hostname for all machines
```
 sudo vim /etc/hosts 
```
ADD
```
<ip-master>   <hostname-master> 
<ip-node1>    <hostname-node1> 
<ip-node2>    <hostname-node2>
```
Check swap config, ensure swap is 0
```
free -m 
```
## step 6: Install Kubernetes on All Machines
Update your existing packages:
```
sudo apt-get update
# Install packages needed to use the Kubernetes apt repository:
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
#  Download the public signing key for the Kubernetes package repositories.
sudo mkdir -p -m 755 /etc/apt/keyrings 
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#  Add Kubernetes Repository:
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg]
https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list 
# Update your existing packages:
sudo apt-get update -y 
# Install Kubeadm:
sudo apt-get install -y kubelet kubeadm kubectl 
sudo apt-mark hold kubelet kubeadm kubectl
# Enable the kubelet service:
sudo systemctl enable --now kubelet 
# Enable kernel modules
sudo modprobe overlay 
sudo modprobe br_netfilter 
# Update Iptables Settings
 sudo tee /etc/sysctl.d/kubernetes.conf<<EOF 
net.bridge.bridge-nf-call-ip6tables = 1 
net.bridge.bridge-nf-call-iptables = 1 
net.ipv4.ip_forward = 1 
EOF
# Configure persistent loading of modules
sudo tee /etc/modules-load.d/k8s.conf <<EOF 
overlay 
br_netfilter 
EOF
# Reload sysctl
sudo sysctl --system 
# Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl restart docker 
sudo systemctl enable docker 
sudo systemctl enable kubelet
```
step 7: Initialize Kubernetes on the Master Node
```
# Run the following command as sudo on the master node:
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 
# To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube 
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config
# To Create a new token as root
sudo kubeadm token create --print-join-command 
# Deploy a Pod Network through the master node:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kubeflannel.yml
```
### 🚫 In the output, you can see the `kubeadm join`command and a unique token that you will run on the
 worker node and all other worker nodes that you want to join onto this cluster. Next, copy-paste this
 command as you will use it later in the worker node.

## step 8: Joining Worker Nodes to the Kubernetes Cluster
 You will use your kubeadm join command that was shown in your terminal when we initialized the master
 node.
 The command would be similar of this:
```
sudo kubeadm join 172.31.6.233:6443 --token 9lspjd.t93etsdpwm9gyfib -discovery-token-ca-cert-hash 
sha256:37e35d7ea83599356de1fc5c80c282285cc3c749443a1dafd8e73f40
```

## step 9:  Reset Kubeadm
```
sudo kubeadm reset -f 
```
## 🔍 Step 8: Verify Nodes & Pods (on Master)

<img width="565" height="103" alt="image" src="https://github.com/user-attachments/assets/becac18f-0df1-44bd-b767-c6d5fd05e77a" />

<img width="1127" height="352" alt="image" src="https://github.com/user-attachments/assets/41aa6438-1ec3-4479-8f09-86af0ddda647" />

## 🖥️ Step 10: Add Taints to Each Node
```
kubectl taint nodes <node-name-1> workload=master:NoSchedule
kubectl taint nodes <node-name-2> workload=app:NoSchedule
kubectl taint nodes <node-name-3> workload=database:NoSchedule
```
🔁 Replace <node-name-X> with names from kubectl get nodes.
<img width="742" height="157" alt="image" src="https://github.com/user-attachments/assets/05769973-d253-4f65-93cc-16b75d186794" />

## ✅ Step 10: Verify Taints
```
kubectl describe node <node-name>
```
Look under the `Taints`: section. You should see:

Taints: workload=master:NoSchedule
<img width="740" height="45" alt="image" src="https://github.com/user-attachments/assets/8306f1a9-6c66-498e-9064-46f9ba1dfa9d" />

Taints: workload=app:NoSchedule
<img width="502" height="37" alt="image" src="https://github.com/user-attachments/assets/882c06ad-3db0-4edd-aae1-52aaaee9c60a" />

Taints: workload=database:NoSchedule
<img width="517" height="37" alt="image" src="https://github.com/user-attachments/assets/af9b0587-3692-4d92-a66e-d4119d888218" />



---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
