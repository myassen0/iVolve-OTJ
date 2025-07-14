# Lab 23: StatefulSet Deployment with Headless Service

## 🧠 Objective

This lab demonstrates how to deploy a **StatefulSet** for a MySQL database in Kubernetes, using a **headless service**, **PersistentVolumeClaim**, **Secrets**, and **Tolerations**. It simulates a production-ready deployment with data persistence and pod-specific DNS resolution.

---

## 🧱 Components Overview

| Component         | Purpose                                                   |
|------------------|-----------------------------------------------------------|
| Secret            | Stores sensitive MySQL root password securely            |
| PVC               | Provides persistent storage to MySQL                     |
| StatefulSet       | Manages MySQL pod with identity and storage              |
| Toleration        | Allows pod to run on tainted nodes with `workload=database` |
| Headless Service  | Enables stable network identity for StatefulSet pods     |

---

## 🛠️ Step-by-Step Implementation

### 🔐 1. Create Secret for MySQL Password

```yaml
# mysql-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  MYSQL_ROOT_PASSWORD: bXlzcWwzMjE=  # mysql321
```
Apply:
```
kubectl apply -f mysql-secret.yaml
```
### 💾 2. Define Persistent Volume (PV)
```yaml
# mysql-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/mysql-data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - worker2
```
Apply:
```
kubectl apply -f mysql-pvc.yaml
```
### 📦 3. Deploy StatefulSet for MySQL
```yaml
# mysql-statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql-headless
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      tolerations:
      - key: "workload"
        operator: "Equal"
        value: "database"
        effect: "NoSchedule"
      containers:
      - name: mysql
        image: mysql:5.7
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_ROOT_PASSWORD
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-storage
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-storage
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi
```
apply:
```
kubectl apply -f mysql-statefulset.yaml
```
### 🌐 4. Create Headless Service for MySQL
```
# mysql-headless-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql-headless
spec:
  clusterIP: None
  selector:
    app: mysql
  ports:
  - port: 3306
```
Apply:
```
kubectl apply -f mysql-headless-svc.yaml
```
## ✅ Verify the Setup
### 1. Check Pods and PVC
```
kubectl get pods -l app=mysql
kubectl get pvc
```
<img width="846" height="240" alt="image" src="https://github.com/user-attachments/assets/c0468396-0561-41f7-bc96-a32964cf475c" />

### 2. Connect to MySQL
```
kubectl exec -it mysql-0 -- sh
mysql -u root -p
# Enter password: mysql321
```
You’re now connected to the MySQL instance running inside a StatefulSet!

<img width="830" height="390" alt="image" src="https://github.com/user-attachments/assets/c0be1abe-7faa-480a-89f1-793b4c1ff9a2" />

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
