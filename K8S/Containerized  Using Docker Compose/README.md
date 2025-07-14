# 🐳 Node.js + MySQL Stack with Docker Compose

---

This project demonstrates how to containerize a **Node.js** application with a **MySQL** database using Docker Compose. The Node.js app connects to a MySQL database named `ivolve`, and the services are orchestrated together using `docker-compose.yml`.

---

## 📖 Lab Objective

The purpose of this lab is to **practice deploying a multi-container application** using Docker Compose. It shows how to:

- Run a backend service (Node.js) that depends on a database (MySQL)
- Connect containers using internal Docker networking
- Manage persistent data using Docker volumes
- Use environment variables for secure and flexible configuration
- Verify application health with custom endpoints
- View application logs and understand how to debug
- Push the final image to DockerHub for reuse or deployment

This is a foundational DevOps skill used in microservices and real-world production environments.

---

## 📦 Prerequisites

Before starting, make sure you have the following installed:

- Docker → [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose → Included with Docker Desktop
- Git
- Docker Hub account

---

## 📁 Step 1: Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/kubernets-app.git
cd kubernets-app
```

## 📝 Step 2: Create `docker-compose.yml`
In the root of the project, create a file called `docker-compose.yml` and add the following:
```
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DB_HOST=db
      - DB_USER=root
      - DB_PASSWORD=my-secret-pw
    depends_on:
      - db
    volumes:
      - ./logs:/app/logs

  db:
    image: mysql:8
    environment:
      - MYSQL_ROOT_PASSWORD=my-secret-pw
      - MYSQL_DATABASE=ivolve
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:

```
## 📄 Step 3: Dockerfile for the App
Make sure your `Dockerfile` for the Node.js app looks like this:
```
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]

```
## ▶️ Step 4: Run the Stack
```
docker-compose up --build
```
This will:
- Build the Node.js app
- Start both app and db containers
- Create a volume db_data for MySQL persistence
- Expose the app on port 3000

<img width="851" height="127" alt="image" src="https://github.com/user-attachments/assets/15eb152a-4856-4dce-b719-20c6e8f6423d" />

## ✅ Step 5: Verify Application Health
After running:
1. Open browser or use curl to verify:
```
curl http://localhost:3000/health
curl http://localhost:3000/ready
```
<img width="1917" height="962" alt="image" src="https://github.com/user-attachments/assets/4e4e1423-5bc7-4f5e-a488-7ab16d09b67e" />

## Health

<img width="605" height="187" alt="image" src="https://github.com/user-attachments/assets/3cad2585-b3ef-446f-a6d6-fd5feaa974a3" />

### Ready:

<img width="567" height="232" alt="image" src="https://github.com/user-attachments/assets/ff4c4b45-e70d-4bda-9ae8-fb6820753628" />

2. Check access logs:
```
cat ./logs/access.log
```
<img width="851" height="453" alt="image" src="https://github.com/user-attachments/assets/5c7ff0a9-ef8b-489c-8388-d508a114def7" />

## ☁️ Step 6: Push Image to Docker Hub
1. 1. Tag your app image:
```
docker tag kubernets-app yourdockerhubusername/kubernets-app:latest
```

2. 2. Login & Push:
```
docker login
docker push yourdockerhubusername/kubernets-app:latest
```
<img width="852" height="247" alt="image" src="https://github.com/user-attachments/assets/8bc638eb-8fd8-4243-bd00-6238f1e4a3e3" />

DockerHub link:
[https://hub.docker.com/repository/docker/yassenn01/kubernets-app/general]
---

# iVolve-OTJ
---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
