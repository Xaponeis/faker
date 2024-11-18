FROM mcr.microsoft.com/java/jre-headless:17-zulu-alpine

ARG APP_VERSION=3.0.1
ENV FAKER_PORT=3030
ENV APP_DIR=/app
ENV APP_FILE=${APP_DIR}/faker.jar
ENV MOCK_DIR=${APP_DIR}/mocks
ENV EXAMPLE_DIR=${APP_DIR}/examples
ENV LOG_FILE=${APP_DIR}/faker.log
ENV APP_RELEASE=https://github.com/xaponeis/faker/releases/download/v${APP_VERSION}/faker.jar
#ENV APP_RELEASE=./build/libs/faker.jar

RUN mkdir -p ${APP_DIR} ${MOCK_DIR}
ADD ${APP_RELEASE} ${APP_FILE}
COPY ./mocks/examples/ ${EXAMPLE_DIR}

EXPOSE 3030
ENTRYPOINT [ "java" ]
CMD [ "-Dserver.port=${FAKER_PORT}", "-Dfaker.source=${MOCK_DIR}", "-Dfaker.example=${EXAMPLE_DIR}", "-jar", "/app/faker.jar" ]
