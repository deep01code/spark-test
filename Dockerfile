# Use a Gradle-based JDK image
FROM gradle:jdk11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy everything from the repo
COPY . .

# Build the project using Gradle
RUN gradle clean build --no-daemon

# Use OpenJDK as the final runtime image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
