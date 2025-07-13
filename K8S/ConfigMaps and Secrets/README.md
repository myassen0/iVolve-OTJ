# 🔐 Lab 21: Managing Configuration and Sensitive Data with ConfigMaps and Secrets

---

This lab demonstrates how to manage application configuration and sensitive data in Kubernetes using **ConfigMaps** and **Secrets**. This helps in separating configuration from code and securely storing sensitive credentials.

---

## 🎯 Lab Objective

- Create a **ConfigMap** to store non-sensitive MySQL config values.
- Create a **Secret** to store MySQL credentials securely.
- Use **Base64 encoding** for secret values.
- Apply the configuration in a Kubernetes environment.

---

## 🧰 Prerequisites

- Kubernetes cluster running (e.g., minikube, kubeadm, etc.)
- kubectl installed and configured
- Basic knowledge of YAML

---

## 🗂️ Step 1: Create a ConfigMap

This will store **non-sensitive** MySQL connection settings.

### ➤ File: `mysql-configmap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: default
data:
  DB_HOST: mysql-service
  DB_USER: ivolve_user
```
🔎 `mysql-service` refers to the hostname of the MySQL StatefulSet service.
`ivolve_user` is the username used by the app to access the `ivolve` database.
Apply the config map:
```bash
kubectl apply -f mysql-configmap.yaml
```
---

## 🔐 Step 2: Create a Secret
Secrets store sensitive information like passwords securely. Kubernetes requires the values to be Base64 encoded.
➤ Encode your values first:
```
echo -n 'your_db_password' | base64
echo -n 'your_root_password' | base64
```
➤ File: `mysql-secret.yaml`
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  namespace: default
type: Opaque
data:
  DB_PASSWORD: eW91cl9kYl9wYXNzd29yZA==           # base64 of 'your_db_password'
  MYSQL_ROOT_PASSWORD: eW91cl9yb290X3Bhc3N3b3Jk     # base64 of 'your_root_password'
```
Apply the secret:
```
kubectl apply -f mysql-secret.yaml
```
---

## ✅ Step 3: Verify ConfigMap and Secret
```
kubectl get configmap mysql-config -o yaml
kubectl get secret mysql-secret -o yaml
```
<img width="851" height="705" alt="image" src="https://github.com/user-attachments/assets/1ccdc28c-8e0e-4488-9314-15e05806a52f" />

To decode secret:
```
kubectl get secret mysql-secret -o jsonpath="{.data.DB_PASSWORD}" | base64 -d
```
<img width="840" height="65" alt="image" src="https://github.com/user-attachments/assets/536655d0-08d6-4c59-beef-29d3deb19efd" />


---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
