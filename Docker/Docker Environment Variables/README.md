# Lab 13: Docker Environment Variables

---

This lab demonstrates how to use environment variables in a Docker container using a simple Flask app.

---

## 🧱 Step 1: Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-3.git
cd Docker-3
```
## 📝 Step 2: Create Dockerfile
```
# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Install Flask
RUN pip install flask

# Set default environment variables (used in production)
ENV APP_MODE=production
ENV APP_REGION=canada-west

# Expose application port
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]
```
## 🗂️ Step 3: Create `env.list` for staging mode
Create a file named env.list with the following content:
```
APP_MODE=staging
APP_REGION=us-west
```
## 🛠️ Step 4: Build the Docker Image
```
docker build -t flask-env-app .
```
## 🚀 Step 5: Run the Container
### 1. Run with environment variables from the command:
```
docker run -d -p 8080:8080\
 -e APP_MODE=development\
 -e APP_REGION=us-east flask-env-app
```
### 2. Run with environment variables from a file:
```
docker run -d -p 8081:8080\
 --env-file env.list flask-env-app
```
### 3. Run using the defaults from Dockerfile:
```
docker run -d -p 8082:8080 flask-env-app
```
## ✅ Verify Inside the Container
```
 http://localhost:8080
 http://localhost:8081
 http://localhost:8082
```
![image](https://github.com/user-attachments/assets/f0012d06-e309-4371-84c2-6a029f076f47)

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]










