FROM maven as build 
WORKDIR /app
COPY . .
RUN install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/Project3.jar /app/
EXPOSE 8080
CMD [ "java","-jar","devops-intergration.jar" ]