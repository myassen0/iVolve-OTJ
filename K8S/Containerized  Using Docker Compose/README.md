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

## ✅ Step 5: Verify Application Health
After running:
1. Open browser or use curl to verify:
```
curl http://localhost:3000/health
curl http://localhost:3000/ready
```
2. Check access logs:
```
cat ./logs/access.log
```

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

---

# iVolve-OTJ
---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
