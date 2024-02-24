#!/bin/bash

WEB_APPS_TOMCAT_DIR=webapps
tomcat_path=$CATALINA_HOME
filename=demo.war
host_address=127.0.0.1
port=$CATALINA_PORT_NUMBER
SERVER_CONFIG_FILE_NAME=$CATALINA_HOME/conf/server.xml

set_host_address(){
  host_address=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
}

set_port_for_tomcat(){
  sed -i 's/<Connector port="[0-9]*"/<Connector port="'"$CATALINA_PORT_NUMBER"'"/' $SERVER_CONFIG_FILE_NAME
}

launch_tomcat(){
  if [[ -z $(netstat -an | grep $CATALINA_PORT_NUMBER) ]]; then
    $CATALINA_HOME/bin/catalina.sh run
  fi
}

stop_tomcat(){
  if [[ $(netstat -an | grep $CATALINA_PORT_NUMBER) ]]; then
    $CATALINA_HOME/bin/catalina.sh stop
  fi

}

undeploy() {
    file_deployed="$tomcat_path/$WEB_APPS_TOMCAT_DIR/$filename"
    if [ ! -f "$file_deployed" ]; then
        echo "File not found: $file_deployed"
        exit 1
    fi
    rm -R "${file_deployed%.*}"
    rm "$file_deployed"
    printf "File %s was removed: %s/%s\n%s" \
        "$filename" "$tomcat_path" "$WEB_APPS_TOMCAT_DIR" "$(ls "$webapp_directory")"
    ls "$tomcat_path/$WEB_APPS_TOMCAT_DIR/"
}

deploy() {
    if [ ! -f "$filename" ]; then
        printf "File not found: %s", "$file_deployed"
        exit 1
    fi
    webapp_directory="$tomcat_path/$WEB_APPS_TOMCAT_DIR/"
    cp "$filename" "$webapp_directory"
    printf "%s was placed in %s:\n%s\n" "$filename" "$webapp_directory" "$(ls "$webapp_directory")"
}

deploy_curl() {
    full_file_name=$(realpath "$filename")
    eval curl -u \'"$username":"$password"\' \
        -T \""$full_file_name"\" \
        \""http://$host_address:""$port"/manager/text/deploy?path="$endpoint""&update=true"\"
}

undeploy_curl() {
    eval curl -u \'"$username":"$password"\' \
        \""http://$host_address:""$port"/manager/text/undeploy?path="$endpoint""&update=true"\"
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u | --undeploy )
                undeploy
                ;;
            -d | --deploy )
                deploy
                ;;
            -p | --path )
                tomcat_path="$2"
                shift
                ;;
            -f | --filename )
                filename="$2"
                shift
                ;;
            -dc | --deploy-curl )
                deploy_curl
                ;;
            -uc | --undeploy-curl )
                undeploy_curl
                ;;
            --username=* )
                username="${1#*=}"
                ;;
            --password=* )
                password="${1#*=}"
                ;;
            --endpoint=* )
                endpoint="${1#*=}"
                ;;
            --port=* )
                port="${1#*=}"
                ;;
            --stop=* )
                stop_tomcat
                ;;
        esac
        shift
    done
}


set_host_address
set_port_for_tomcat
parse_arguments "$@"
launch_tomcat
