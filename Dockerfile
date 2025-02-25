FROM eclipse-temurin:17

# Install ping utility
RUN apt-get update && apt-get install -y iputils-ping && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# At runtime, Java will run with any options passed via JAVA_OPTS.
# It looks for the first .jar file in /app and executes it.
CMD ["sh", "-c", "java $JAVA_OPTS -jar $(ls /app/*.jar | head -n 1)"]
