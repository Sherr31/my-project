# ===== Stage 1: Build =====
FROM eclipse-temurin:8-jdk AS builder

WORKDIR /app

# Copy only necessary files first (better caching)
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon

# ===== Stage 2: Final small image =====
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app
COPY --from=builder /app/build/libs/java-app-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
