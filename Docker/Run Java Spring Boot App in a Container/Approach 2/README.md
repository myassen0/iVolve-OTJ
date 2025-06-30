# 🚀 Spring Boot Docker Lab – Approach 2

This lab demonstrates how to containerize a Java Spring Boot application by **building it locally using Maven**, and then packaging only the compiled `.jar` into a Docker image.

---

## 🎯 Lab Objectives (Approach 2)

- Build a Spring Boot application locally using Maven.
- Package the final `.jar` into a lightweight Docker image.
- Expose the application on port 8080 and run it in a container.
- Test, stop, and clean up the running container.

---

## 📁 Step 1: Clone the Repository

```bash
git clone https://github.com/lbrahim-Adel15/Docker-1.git
cd Docker-1
```

## 🛠️ Step 2: Build the App Locally with Maven
Ensure you have Maven and Java 17+ installed on your machine.
```
mvn clean package -DskipTests
```
![image](https://github.com/user-attachments/assets/47376d04-164b-4349-b901-bab8bcee8a38)


✅ This should generate a file at: `target/demo-0.0.1-SNAPSHOT.jar`

## 🐳 Step 3: Create a Dockerfile

Create a file named `Dockerfile`:
```
# Use a lightweight Jre image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the pre-built JAR
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
```
## 🏗️ Step 4: Build the Docker Image
```
docker build -t springboot-demo-local .
```
## ▶️ Step 5: Run the Container
```
docker run -d --name springboot-app-local -p 8081:8080 springboot-demo-local
```
🔍 Step 6: Test the Application
```
curl http://localhost:8081
```
![image](https://github.com/user-attachments/assets/ec7321e8-4dcf-4205-bf6b-6d640d8ec9f8)

## 📦 Image Info
- Base image: `eclipse-temurin:17-jre-alpine`
- Build tool: `Maven (run locally, not inside Docker)`
- Final JAR: `target/demo-0.0.1-SNAPSHOT.jar`
- Exposed port: `8081`
- size: `200MB`

## ✅ Summary

This approach is ideal for production because:
- It produces a smaller, faster, and more secure image.
- The image contains only the app and a minimal runtime — no source code or build tools.
- You retain full control over the build process and artifacts.

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]





