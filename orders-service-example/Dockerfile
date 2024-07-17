FROM maven:3.8.4-openjdk-11 AS package
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:8-jdk-alpine
COPY --from=package /target/orders-service-example-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 8083
ARG PAYMENTS_SERVICE_ENDPOINT
ARG PRODUCTS_SERVICE_ENDPOINT
ARG SHIPPING_SERVICE_ENDPOINT
ENTRYPOINT ["java","-jar","/app.jar","--server.port=8083","$PAYMENTS_SERVICE_ENDPOINT", "$PRODUCTS_SERVICE_ENDPOINT", "$SHIPPING_SERVICE_ENDPOINT"]