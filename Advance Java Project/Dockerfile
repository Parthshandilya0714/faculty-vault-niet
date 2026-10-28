# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/faculty-vault-1.0.0.war app.war
EXPOSE 8080
# Use shell form so it accepts Java system properties/arguments properly
ENTRYPOINT sh -c 'java -Dspring.datasource.url=$SPRING_DATASOURCE_URL -Dspring.datasource.username=$SPRING_DATASOURCE_USERNAME -Dspring.datasource.password=$SPRING_DATASOURCE_PASSWORD -jar app.war'
