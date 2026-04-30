FROM openjdk:17-jdk-slim
VOLUME /tmp
EXPOSE 8089
ARG JAR_FILE=target/achat-1.0.jar
COPY ${JAR_FILE} achat.jar
ENTRYPOINT ["java","-jar","/achat.jar"]
