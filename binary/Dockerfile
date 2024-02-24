FROM tomcat:jre21

ARG SCRIPT=deploy_on_tomcat.sh


ARG WORKDIR_PATH=/app
WORKDIR ${WORKDIR_PATH}

ENV CATALINA_PORT_NUMBER=8091
EXPOSE ${CATALINA_PORT_NUMBER}

ENV APP_NAME webSocket.war
ENV TOMCAT_NAME catalina.sh

ENV LAUNCH_SCRIPT_PATH ${WORKDIR_PATH}/deploy_on_tomcat.sh

COPY ${APP_NAME} ${WORKDIR_PATH}
COPY ${SCRIPT} ${LAUNCH_SCRIPT_PATH}

RUN chmod +x ${LAUNCH_SCRIPT_PATH}

RUN   apt update \
      && apt install net-tools

ENTRYPOINT ${LAUNCH_SCRIPT_PATH} -f ${APP_NAME} --username=admin --password=admin --endpoint=/chat -d -p ${pwd}