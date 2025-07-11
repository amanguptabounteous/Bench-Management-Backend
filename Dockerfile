# Stage 1: Build the application
FROM eclipse-temurin:17-jdk-jammy as builder
WORKDIR /app
COPY bench-backend/gradlew .
COPY bench-backend/gradle ./gradle
COPY bench-backend/build.gradle .
COPY bench-backend/settings.gradle .
COPY bench-backend/src ./src
RUN chmod +x ./gradlew
RUN ./gradlew build --no-daemon

# Stage 2: Create the final, smaller runtime image
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
