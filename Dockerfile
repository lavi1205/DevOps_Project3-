FROM maven as build 
# RUN mvn clean compile

WORKDIR /app
COPY . .
#RUN mvn clean install -X
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/devops-integration.jar /app/
EXPOSE 8080
CMD [ "java","-jar","devops-intergration.jar" ]