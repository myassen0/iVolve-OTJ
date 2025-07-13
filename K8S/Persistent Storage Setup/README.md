# 💾 Lab 22: Persistent Storage Setup for Application Logging

This lab demonstrates how to configure **persistent storage** in Kubernetes for application logs using **Persistent Volumes (PV)** and **Persistent Volume Claims (PVC)**. The goal is to ensure that logs are retained even if the application pods are recreated.

---

## 🎯 Lab Objective

- Create a **Persistent Volume (PV)** backed by the node’s file system (hostPath).
- Create a **Persistent Volume Claim (PVC)** requesting 1Gi of storage.
- Match access mode as **ReadWriteMany** to allow multiple pods to access the volume simultaneously.
- Use **Retain** policy to keep data even after PVC deletion.

---

## 🧰 Prerequisites

- Kubernetes cluster (Minikube, kubeadm, etc.)
- At least one node labeled or used for the app
- `/mnt/app-logs` folder must exist on the node with 777 permissions

---

## 📁 Step 1: Prepare HostPath Directory on Node

SSH into the app "worker" node (or Minikube node) and run:

```bash
sudo mkdir -p /mnt/app-logs
sudo chmod 777 /mnt/app-logs
```
---

## 📦 Step 2: Define Persistent Volume (PV) into master node
➤ File: `pv.yaml`
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-logs-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/app-logs
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - worker2
```
Apply the PV:
```
kubectl apply -f pv.yaml
```

---

## 📦 Step 3: Define Persistent Volume Claim (PVC)
➤ File: `pvc.yaml`
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-logs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```
Apply the PVC:
```
kubectl apply -f pvc.yaml
```

---

## 🔍 Step 4: Verify Binding

Check that the PVC is successfully bound to the PV:
```
kubectl get pvc
kubectl get pv
```
output
<img width="1412" height="127" alt="image" src="https://github.com/user-attachments/assets/039c1268-7547-45a4-993c-762df6328abe" />

---
## 🧪 Step 5: Test the Persistent Volume with a Logging Pod

To verify that the PV and PVC are working correctly, we can create a test pod that writes to the mounted volume.

### ➤ File: `logger-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: logger
spec:
  nodeName: worker2  # تأكيد إن البود يروح لنفس النود
  containers:
  - name: busybox
    image: busybox:1.36.1
    command: ["sh", "-c", "while true; do date >> /logs/log.txt; sleep 5; done"]
    volumeMounts:
    - mountPath: /logs
      name: log-volume
  volumes:
  - name: log-volume
    persistentVolumeClaim:
      claimName: app-logs-pvc
```
✅ Apply the Pod:
```
kubectl apply -f logger-pod.yaml
```
🔍 Confirm the Pod is Running:
```
kubectl get pods
```
<img width="841" height="128" alt="image" src="https://github.com/user-attachments/assets/791297be-4531-4f99-acf8-db2ad87d61e4" />

---

## 🧾 Step 6: Check if Logs Are Written on the Node
SSH into the worker node where the volume was mounted (`worker-node-1` for example), then:
```
sudo tail -f /mnt/app-logs/log.txt
```
You should see the current timestamps being appended every 5 seconds like:
<img width="597" height="262" alt="image" src="https://github.com/user-attachments/assets/46d15fc7-c885-4e19-9f72-0ac6e48e45e0" />

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]






