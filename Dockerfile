FROM maven as build 
# RUN mvn clean compile
# RUN mvn clean install -X
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/Project3.jar /app/
EXPOSE 8080
CMD [ "java","-jar","devops-intergration.jar" ]