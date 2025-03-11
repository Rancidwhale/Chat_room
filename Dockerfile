FROM maven AS build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:17-alpine
COPY --from=build /app/target/chatroom-0.0.1-SNAPSHOT.jar app.jar 
ENTRYPOINT ["java", "-jar", "app.jar"]
