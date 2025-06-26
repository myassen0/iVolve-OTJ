# Lab 10: Build Java App using Maven

This lab demonstrates how to build a Java application using **Apache Maven**. It includes installing Maven, cloning the source code, running tests, building the application, and verifying it works.

---

## 📋 Prerequisites

- CentOS (7/8/Stream 9)
- Java 17+
- Apache Maven installed

---

## 🛠️ 1. Install Maven

```bash
sudo dnf install maven -y
mvn -v
```
![image](https://github.com/user-attachments/assets/0224323c-c5ae-4760-8180-9870dcc398cd)

---

## 📥 2. Clone the Repository
```
git clone https://github.com/Ibrahim-Adel15/build2.git
cd build2
```
---

## ✅ 3. Run Unit Tests
```
mvn test
```
![image](https://github.com/user-attachments/assets/99c49e0a-c62e-4264-9ff7-0a0252d19c67)

---

## 🏗️ 4. Build the Application
```
mvn package
```
Output JAR will be located at:

`target/hello-ivolve-1.0-SNAPSHOT.jar`

![image](https://github.com/user-attachments/assets/2ed1b7f6-8bf1-498f-b876-aaf320d338a2)


---
## ▶️ 5. Run the Application

```
java -jar target/hello-ivolve-1.0-SNAPSHOT.jar
```
---

## 🔍 6. Verify Output
` Hello iVolve Trainee`

![image](https://github.com/user-attachments/assets/130f88d4-66db-4b49-8482-a425d1febd0f)

---

# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]









