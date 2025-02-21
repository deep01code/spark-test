#!/bin/bash

# Directories
PROJECT_DIR="/Users/yasser/Desktop/experement"  # Project files directory
LOG_DIR="$PROJECT_DIR/logs"                     # Logs directory
NETWORK="spark-network"                         # Docker network name

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Get a human-friendly timestamp for log filenames
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# Function to log messages with timestamps
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1"
}

# Build Gradle Docker image with ping support
log "Building custom Gradle image with ping support..."
docker build -t gradle-jdk11-with-ping - <<EOF
FROM gradle:jdk11
USER root
RUN apt-get update && apt-get install -y iputils-ping
USER gradle
WORKDIR /home/gradle
EOF



# Step 1: Start Spark Master
MASTER_LOG="$LOG_DIR/spark-master-$TIMESTAMP.log"
log "Starting Spark Master..."
docker run --rm --name spark-master --hostname spark-master --network $NETWORK -p 7077:7077 -p 8080:8080 bitnami/spark:latest spark-class org.apache.spark.deploy.master.Master | while IFS= read -r line; do log "$line"; done > "$MASTER_LOG" 2>&1 &
log "Spark Master is starting. Logs are being written to $MASTER_LOG"

# Step 2: Start Spark Worker 1
WORKER1_LOG="$LOG_DIR/spark-worker-1-$TIMESTAMP.log"
log "Starting Spark Worker 1..."
docker run --rm --name spark-worker-1 --hostname spark-worker-1 --network $NETWORK bitnami/spark:latest spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077 | while IFS= read -r line; do log "$line"; done > "$WORKER1_LOG" 2>&1 &
log "Spark Worker 1 is starting. Logs are being written to $WORKER1_LOG"

# Step 3: Start Spark Worker 2
#WORKER2_LOG="$LOG_DIR/spark-worker-2-$TIMESTAMP.log"
#log "Starting Spark Worker 2..."
#docker run --rm --name spark-worker-2 --hostname spark-worker-2 --network $NETWORK bitnami/spark:latest spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077 | while IFS= read -r line; do log "$line"; done > "$WORKER2_LOG" 2>&1 &
#log "Spark Worker 2 is starting. Logs are being written to $WORKER2_LOG"

# Pause briefly to let the cluster initialize
sleep 5
log "Spark cluster setup is complete."

# Rebuild Java application with Gradle cache
BUILD_LOG="$LOG_DIR/java-build-$TIMESTAMP.log"
log "Rebuilding the Java application..."
docker run --rm --network $NETWORK \
    -v "$PROJECT_DIR:/app" \
    -v "$HOME/.gradle:/home/gradle/.gradle" \
    gradle-jdk11-with-ping \
    bash -c "cd /app && ping -c 3 spark-master && gradle compileJava --no-daemon" | while IFS= read -r line; do log "$line"; done > "$BUILD_LOG" 2>&1

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    log "Java application rebuilt successfully. Logs are available at $BUILD_LOG"
else
    log "Java application rebuild failed. Check build logs at $BUILD_LOG for details."
    exit 1
fi

# Run the Java Spark application
USER_OUTPUT_LOG="$LOG_DIR/user-output-$TIMESTAMP.log"
log "Running the Java Spark application..."
docker run --rm --network $NETWORK -v "$PROJECT_DIR:/app" -v "$PROJECT_DIR/build.gradle:/app/build.gradle" -v "$PROJECT_DIR/Main.java:/app/src/main/java/Main.java" gradle-jdk11-with-ping bash -c "cd /app && ping -c 3 spark-master && gradle run" | while IFS= read -r line; do log "$line"; done | tee "$USER_OUTPUT_LOG"

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    log "Java Spark application executed successfully. Logs are available at $USER_OUTPUT_LOG"
else
    log "Java Spark application failed. Check logs at $USER_OUTPUT_LOG for details."
    exit 1
fi

# Final message
log "All tasks are complete. Check the logs in $LOG_DIR for detailed information."
