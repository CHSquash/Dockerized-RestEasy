FROM alpine

ENV JAVA_HOME  /usr/lib/jvm/java-1.8-openjdk
ENV M2_HOME /usr/local/apache-maven/apache-maven-3.3.9
ENV PATH ${PATH}:${M2_HOME}/bin

ENV MAVEN_OPTS "-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=n"

RUN apk update \
  && apk add \
    bash curl openjdk8 jetty-runner \
  && rm -rf \
    /tmp/* \
    /var/cache/apk/*

ADD apache-maven-3.3.9-bin.tar.gz /usr/local/apache-maven/

COPY src /app/RestEasy/src
COPY WebContent /app/RestEasy/WebContent
COPY pom.xml /app/RestEasy/pom.xml
WORKDIR /app/RestEasy

EXPOSE 8080
RUN mvn package

CMD java \
    -jar /usr/share/java/jetty-runner.jar \
    --port 8080 \
    /app/RestEasy/target/RESTfulExample.war
