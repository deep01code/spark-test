# Use a Gradle base image for the build stage
FROM gradle:jdk11 AS builder

WORKDIR /workspace
COPY . .

# Build the project (avoid running this in runtime)
RUN gradle clean build --no-daemon

# Use a lightweight Java runtime image
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy only the compiled JAR from the builder stage
COPY --from=builder /workspace/build/libs/app.jar app.jar

# Set the default command
CMD ["java", "-jar", "app.jar"]
