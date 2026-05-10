FROM eclipse-temurin:17-jdk-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
VOLUME /tmp
EXPOSE 8089
ARG JAR_FILE=target/achat-1.0.jar
COPY ${JAR_FILE} achat.jar
RUN chown appuser:appgroup achat.jar
USER appuser
ENTRYPOINT ["java","-jar","/achat.jar"]
