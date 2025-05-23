FROM maven
WORKDIR /app
COPY . /app
RUN mvn clean package
CMD ["java", "-jar", "target/chatroom-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080