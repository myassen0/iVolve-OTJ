# Lab 16: Docker Compose for Node.js + PostgreSQL App

---

This project demonstrates how to use Docker Compose to run a Node.js application connected to a PostgreSQL database.

---

## 📁 Project Structure
```
├── Dockerfile
├── docker-compose.yml
├── index.js (or app.js)
├── package.json

```

---

## 🐳 Docker Compose Services

### 1. `app` - Node.js Service
- Builds the image from the provided `Dockerfile`.
- Exposes port `3000`.
- Depends on the `db` service (PostgreSQL).
- Uses custom network `mynet`.

### 2. `db` - PostgreSQL Service
- Image: `postgres:15-alpine`
- Exposes port `5432`.
- Environment variables:
  - `POSTGRES_USER=postgres`
  - `POSTGRES_PASSWORD=postgres`
  - `POSTGRES_DB=postgres`
- Mounts volume `postgres_data` to persist data.
- Uses custom network `mynet`.

---

## 🔧 Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/Ibrahim-Adel15/docker6.git
cd docker6
```
### 2. Run Docker Compose
```
docker-compose up --build
```
### 3. Access the App
Open your browser and go to:
👉`http://localhost:3000`

---
## 📦 Volumes & Networks

### Volumes:
- `postgres_data`: Persistent storage for PostgreSQL data.

### Networks:
- `mynet`: Custom bridge network shared between services.

---

## 🧹 Cleanup
To stop and remove containers, networks, and volumes:
```
docker-compose down -v
```

---

## 📝 Notes
Make sure your application is configured to connect to the DB using:
Host: `db`
User: `postgres`
Password: `postgres`
Database: `postgres`
Port: `5432`

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
















