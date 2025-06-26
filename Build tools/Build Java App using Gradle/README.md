# Lab 9: Build Java App using Gradle

---

This lab demonstrates how to build a Java application using **Gradle**. It includes steps to install dependencies, clone the source code, run unit tests, generate a JAR artifact, and run the application.

---

## 📋 Prerequisites

- CentOS 8 Stream or 9 Stream (or equivalent Linux system)
- `java-17-openjdk` and `gradle` installed
- `git` installed

---

## 🛠️ 1. Install Java & Gradle

### Install Java 17

```bash
sudo dnf install java-17-openjdk java-17-openjdk-devel -y
```
### Install Gradle 8.7
```
sudo dnf install wget unzip -y
wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -P /tmp
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle /tmp/gradle-8.7-bin.zip
sudo ln -s /opt/gradle/gradle-8.7 /opt/gradle/latest
# Configure Gradle Environment
echo 'export GRADLE_HOME=/opt/gradle/latest' | sudo tee /etc/profile.d/gradle.sh
echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' | sudo tee -a /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
# Verify Gradle Version
gradle -v
```
![image](https://github.com/user-attachments/assets/ed1511bb-e029-4124-a9d0-78a900a5d59c)

---

## 📦 2. Clone the Application Repository
```
git clone https://github.com/ibrahim-Adel15/build1.git
cd build1
```
---
## ✅ 3. Run Unit Tests
```
gradle test
```
![image](https://github.com/user-attachments/assets/51134d4e-99d4-4d28-862b-6353f958e22f)

---

## 🧱 4. Build the Application
```
gradle build
```
![image](https://github.com/user-attachments/assets/c37afaf7-718b-46b3-a62e-58e483ca0e11)

Artifact will be generated at:
```
build/libs/ivolve-app.jar
```
---

## ▶️ 5. Run the Application
```
java -jar build/libs/ivolve-app.jar
```
---
## ✅ 6. Verify the App is Working

Expected output: `Hello iVolve Trainee`
![image](https://github.com/user-attachments/assets/5009cc4c-28f0-46da-a85b-0cd4880b2137)

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
















