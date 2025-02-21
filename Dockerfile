# Use Gradle with OpenJDK for dynamic builds
FROM gradle:jdk11 AS builder

# Set working directory
WORKDIR /app

# Copy the Gradle build file dynamically at runtime
COPY build.gradle /app/

# Create necessary directories for source files
RUN mkdir -p /app/src/main/java

# Run Gradle commands dynamically at runtime
ENTRYPOINT ["gradle", "run", "--no-daemon"]
