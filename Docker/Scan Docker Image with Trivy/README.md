# Lab 17: Scan Docker Image with Trivy

---

This lab demonstrates how to containerize a Java Spring Boot application using Maven, scan the Docker image for vulnerabilities using Trivy, and push the image to DockerHub.

---
## 🛠 Prerequisites

- Docker
- Maven
- Trivy (installation instructions below)
- DockerHub account

---
## 🚀 Steps

### 1. Clone the Application Code

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```

### 2. Create Dockerfile
```
# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
### 3. Build the Docker Image
```
docker build -t yourdockerhubusername/demo-app:latest .
```
![image](https://github.com/user-attachments/assets/2e051740-d8e7-4d0e-88a0-73accb878228)

### 4. Install Trivy

Visit https://trivy.dev

Or run this quick install command for Linux:

```
sudo curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
```
Check version:
```
trivy --version
```
![image](https://github.com/user-attachments/assets/afa6c016-b72c-4162-b193-35bffeb9cb5b)

### 5. Scan the Image with Trivy
```
trivy image --format json --output trivy-report.json yourdockerhubusername/demo-app:latest
```
![image](https://github.com/user-attachments/assets/a68d3558-3c14-4452-9280-f9661c39d027)

✅ This will generate a vulnerability report in JSON format.

### 6. Push Image to DockerHub
```
docker login
docker push yourdockerhubusername/demo-app:latest
```
![image](https://github.com/user-attachments/assets/3d966acd-f7a0-4ce2-8b1d-2746a05ab02d)

---
## 📄 Output Files
- `trivy-report.json`: Contains the scan report (JSON format).
- `demo-app:latest`: Docker image available on DockerHub.

---
## 📌 Notes
- Ensure `target/demo-0.0.1-SNAPSHOT.jar` is created before building the Docker image.
- You can customize the image tag or DockerHub repo name as needed.

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]

















