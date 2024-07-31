FROM maven:3-eclipse-temurin-22-alpine as build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package

FROM eclipse-temurin:22-jre-alpine as prod
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
