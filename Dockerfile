# Stage 1 - Build
FROM eclipse-temurin:8-jdk-alpine AS builder
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew clean build -x test

# Stage 2 - Final small image
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/java-app-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
