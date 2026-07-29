# ===== Stage 1: Build the JAR =====
FROM eclipse-temurin:8-jdk AS builder

WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew clean build -x test

# ===== Stage 2: Final small image =====
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app
COPY --from=builder /app/build/libs/java-app-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
