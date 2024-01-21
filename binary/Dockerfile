FROM tomcat:jre21

ARG SCRIPT=deploy_on_tomcat.sh

ENV APP_NAME webSocket.war
ENV LAUNCH_SCRIPT_PATH /app/deploy_on_tomcat.sh
RUN chmod +x ${LAUNCH_SCRIPT_PATH}

WORKDIR /app

COPY ${APP_NAME} /app
COPY ${SCRIPT} ${LAUNCH_SCRIPT_PATH}

RUN echo $APP_NAME && ls -ah

CMD ${LAUNCH_SCRIPT_PATH} -f webSocket.war --username=admin --password=admin --endpoint=/chat --port=8091 -uc