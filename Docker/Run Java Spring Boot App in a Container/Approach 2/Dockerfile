# Use a lightweight JRE image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the pre-built JAR
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
