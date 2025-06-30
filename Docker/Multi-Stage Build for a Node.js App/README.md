# 🚀 Lab 12: Multi-Stage Build for a Java Spring Boot App

---

This lab demonstrates how to use a **multi-stage Docker build** to build and run a Java Spring Boot application efficiently using separate build and runtime environments.

---

## 🎯 Lab Objectives

- Clone a Spring Boot application from GitHub.
- Write a Dockerfile using multi-stage build:
  - Use Maven image to build the app.
  - Use a lightweight Java image to run the app.
- Build and run the Docker image.
- Test the application via HTTP.
- Clean up Docker resources.

---

## 📁 Step 1: Clone the Application Code

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```
## 🐳 Step 2: Create va Multi-Stage Dockerfile
Create a file named `Dockerfile` in the project root:
```
# Stage 1: Build the app with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the app using a lightweight Java image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
## 🏗️ Step 3: Build the Docker Image
```
docker build -t springboot-multistage .
```
▶️ Step 4: Run the Container
```
docker run -d --name springboot-app -p 8080:8080 springboot-multistage
```
## 🔍 Step 5: Test the Application
```
curl http://localhost:8080
```
## 🧹 Step 6: Stop and Delete the Container
```
docker stop springboot-app
docker rm springboot-app
```
## ✅ Summary

This approach uses a multi-stage build to separate the build process from the runtime environment. It produces a small, production-ready image by:

- Compiling the app with Maven in the first stage.
- Running it in a lightweight Java runtime container.

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]












