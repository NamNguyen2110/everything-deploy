FROM adoptopenjdk/openjdk11:alpine-jre
VOLUME /tmp
ADD /target/test-jenkins-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 3333
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]