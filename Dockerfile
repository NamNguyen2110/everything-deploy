#FROM adoptopenjdk/openjdk11:alpine-jre
#VOLUME /tmp
#ADD /target/test-jenkins-0.0.1-SNAPSHOT.jar app.jar
#EXPOSE 3333
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

FROM adoptopenjdk/openjdk11:alpine-jre
ARG JAR_FILE=target/*.jar
WORKDIR /opt/app
COPY ${JAR_FILE} application.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Duser.timezone=GMT+7","-Dspring.profiles.active=dev,swagger","-jar","application.jar"]