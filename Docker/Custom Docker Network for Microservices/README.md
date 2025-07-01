# 🧪 Lab 15: Custom Docker Network for Microservices

This lab demonstrates how to build and connect microservices (frontend and backend) using Docker containers and a custom Docker network.

## 🔗 Repository
📁 Clone the project from GitHub:
```bash
git clone https://github.com/Ibrahim-Adel15/Docker5.git
cd Docker5
```
## 🐳 Dockerfile for Frontend
### Create `Dockerfile` inside `frontend/` directory:
```
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```
### Build frontend image:
```
docker build -t frontend-image -f frontend/Dockerfile .
```
![image](https://github.com/user-attachments/assets/d3a856f1-2db8-43d2-8a43-ed8cc2201470)

## 🐳 Dockerfile for Backend
### Create `Dockerfile` inside `backend/` directory:
```
FROM python:3.9

WORKDIR /app

RUN pip install flask

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```
### Build backend image:
```
docker build -t backend-image -f backend/Dockerfile .
```
![image](https://github.com/user-attachments/assets/839bbce1-8cf8-4bb2-af70-f42f6709ab31)

## 🌐 Create Docker Network
Create a custom Docker network named `ivolve-network`:
```
docker network create ivolve-network
```
## 🚀 Run Containers
### 🟨 Run Backend Container
```
docker run -d \
  --name backend \
  --network ivolve-network \
  backend-image
```
### 🟩 Run Frontend Container #1 (Port 5000)
```
docker run -d \
  --name frontend1 \
  --network ivolve-network \
  -p 5000:5000 \
  frontend-image
```
### 🟦 Run Frontend Container #2 (Port 5001)
```
docker run -d \
  --name frontend2 \
  -p 5001:5000 \
  frontend-image
```
## 🔍 Test Communication
You can now access the services:
- Frontend1: `http://localhost:5000`
![image](https://github.com/user-attachments/assets/891e797e-07a3-4756-98a0-f7d074cc0fd7)

- Frontend2: `http://localhost:5001`
![image](https://github.com/user-attachments/assets/d7d55aa7-c9e3-487d-a726-1f3715bb809c)


---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]








