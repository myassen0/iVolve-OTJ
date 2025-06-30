# 🚀 Spring Boot Docker Lab – Approach 1

---

This lab demonstrates how to containerize a Java Spring Boot application by building it **inside the Docker container** using a **multi-stage Dockerfile**.

---

## 🎯 Lab Objectives (Approach 1)

- Build and package a Spring Boot app using Maven inside the container.
- Create a multi-stage Dockerfile (builder + runtime).
- Expose and run the app in a lightweight JDK environment.
- Use Docker CLI to build, run, test, and clean up the container.

---

## 📁 Step 1: Clone the Repository

```bash
git clone https://github.com/lbrahim-Adel15/Docker-1.git
cd Docker-1
```

---

## 🐳 Step 2: Create Dockerfile (Multi-Stage)
Create a file named `Dockerfile` :
```
# Stage 1: Build the application using Maven and Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the application in a lightweight JDK environment
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## 🏗️ Step 3: Build the Docker Image
```
docker build -t springboot-demo .
```
## ▶️ Step 4: Run the Container
```
docker run -d --name springboot-app -p 8080:8080 springboot-demo
```
## 🔍 Step 5: Test the Application
```
curl http://localhost:8080
```
![image](https://github.com/user-attachments/assets/598b1118-e78b-4605-816d-e1947f735ad6)


## 📦 Image Info

- Base image (build stage): `maven:3.9.6-eclipse-temurin-17`
- Base image (runtime stage): `eclipse-temurin:17-jdk-alpine`
- Exposed port: `8080`
- Final JAR: `target/demo-0.0.1-SNAPSHOT.jar`
- Size: `352MB`

## ✅ Summary
This approach is great for automation and CI/CD, as Docker handles both building and running the application. However, the image size is larger than runtime-only images, so it's less ideal for production.


---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]







