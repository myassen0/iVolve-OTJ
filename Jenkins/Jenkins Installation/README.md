# Lab 32: Jenkins Installation (Option 2 - Deploy as a Pod)

## 🎯 Objective

Deploy Jenkins as a container inside a Kubernetes cluster using a Deployment and expose it via a NodePort service.

---

## 🧱 Components Used

| Component      | Description                                  |
|----------------|----------------------------------------------|
| Deployment     | Runs the Jenkins container with 1 replica    |
| NodePort Service | Exposes Jenkins to access it via browser    |
| Volume         | Temporary volume (emptyDir) for Jenkins data |

---

## 🛠️ Steps to Deploy Jenkins

### 1. Create Deployment for Jenkins

```yaml
# jenkins-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: jenkins-data
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins-data
        emptyDir: {}
```

### 2. Create NodePort Service to Access Jenkins
```
# jenkins-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
spec:
  type: NodePort
  selector:
    app: jenkins
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
    nodePort: 30080
```
### 3. Apply the Files
```
kubectl apply -f jenkins-deployment.yaml
kubectl apply -f jenkins-service.yaml
```
### 4. Access Jenkins in Browser
```
http://<Your-Node-IP>:30080
```
Replace <Your-Node-IP> with the IP of your worker node.
### 5. Get Jenkins Initial Admin Password
```
kubectl get pods
kubectl exec -it <jenkins-pod-name> -- cat /var/jenkins_home/secrets/initialAdminPassword
```
Copy the password and paste it in the setup screen of Jenkins.



















