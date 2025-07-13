# 🧱 Lab 20: Namespace Management and Resource Quota Enforcement

---

This lab demonstrates how to manage **namespaces** and enforce **resource quotas** in Kubernetes. Resource quotas are used to limit the usage of resources such as CPU, memory, and the number of objects like Pods within a namespace.

---

## 🎯 Lab Objective

The goal of this lab is to:

- Create a custom namespace `ivolve`
- Apply a **resource quota** to limit the number of pods to **2** within that namespace
- Understand how Kubernetes controls resource consumption per namespace

This is useful in **multi-tenant clusters** to prevent a single team or app from consuming all resources.

---

## ⚙️ Step 1: Create a Namespace

```bash
kubectl create namespace ivolve
```

🔍 Verify:
```
kubectl get namespaces
```
<img width="481" height="213" alt="image" src="https://github.com/user-attachments/assets/a3d93825-4e84-46be-ae12-6314e4b457cc" />

## 📝 Step 2: Define the ResourceQuota
Create a file called `resource-quota.yaml` with the following content:
```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: pod-quota
  namespace: ivolve
spec:
  hard:
    pods: "2"
```
Apply the quota:
```
kubectl apply -f resource-quota.yaml
```
## 🔍 Step 3: Verify the Quota
```
kubectl get resourcequota -n ivolve
```
output:
<img width="707" height="66" alt="image" src="https://github.com/user-attachments/assets/c29e57b2-c43d-4284-bcb7-e5df1fa99acd" />


## 🧪 Optional Test
Try creating 3 pods in the `ivolve` namespace.
The third one should fail due to the pod quota limit:
```
kubectl run pod1 --image=nginx -n ivolve
kubectl run pod2 --image=nginx -n ivolve
kubectl run pod3 --image=nginx -n ivolve
```
The third pod should stay in Pending and you will see an error:
```
pods "pod3" is forbidden: exceeded quota: pod-quota, requested: pods=1, used: 2, limited: 2
```
<img width="856" height="145" alt="image" src="https://github.com/user-attachments/assets/3500de97-527b-4999-8e51-d10328f2cfb0" />

<img width="860" height="307" alt="image" src="https://github.com/user-attachments/assets/8b3814cb-bb09-435a-b1d1-371f809dc60e" />


---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
