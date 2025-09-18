# Use official OpenJDK runtime as base
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file built by Maven into the container
COPY target/calculator-ui-1.0-SNAPSHOT.jar app.jar

# Expose port (if your app is a web app running on 8080)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
