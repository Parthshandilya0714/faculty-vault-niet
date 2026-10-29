# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml ./pom.xml
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/faculty-vault-1.0.0.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.datasource.url=jdbc:postgresql://db.pluvntupezycmtalkvop.supabase.co:5432/postgres", "-Dspring.datasource.username=postgres", "-Dspring.datasource.password=Palak@071407", "-Dspring.datasource.driver-class-name=org.postgresql.Driver", "-jar", "app.war"]
