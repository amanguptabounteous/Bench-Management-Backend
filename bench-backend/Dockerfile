# Stage 1: Build the application with JDK 21
FROM eclipse-temurin:21-jdk-jammy as builder
WORKDIR /app
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle .
COPY settings.gradle .
COPY src ./src
RUN chmod +x ./gradlew
RUN ./gradlew build --no-daemon --stacktrace

# Stage 2: Create the final, smaller runtime image with JRE 21
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
