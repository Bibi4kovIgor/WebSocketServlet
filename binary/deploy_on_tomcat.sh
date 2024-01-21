#!/bin/bash

WEB_APPS_TOMCAT_DIR=webapps
tomcat_path=/home/ihor/Tomcat/apache-tomcat-11.0.0-M3
filename=demo.war

for opt in "$@"; do
    case "$opt" in
        -u | --undeploy )
          file_deployed="$tomcat_path"/"$WEB_APPS_TOMCAT_DIR"/"$filename"
          if [ ! -f "$file_deployed" ]; then
            echo "File not found: $file_deployed"
            exit 1
          fi
          rm -R "${file_deployed%.*}"
          rm "$file_deployed"
          printf "File %s was removed: %s/%s\n%s" \
          $filename $tomcat_path $WEB_APPS_TOMCAT_DIR "$(ls "$webapp_directory")"
          ls "$tomcat_path"/"$WEB_APPS_TOMCAT_DIR"/
          ;;
        -d | --deploy )
          if [ ! -f "$filename" ]; then
            printf "File not found: %s", $file_deployed
            exit 1
          fi
          webapp_directory="$tomcat_path"/"$WEB_APPS_TOMCAT_DIR"/
          cp "$filename" "$webapp_directory"
          printf "%s was placed in %s:\n%s\n" $filename $webapp_directory "$(ls "$webapp_directory")"
          ;;
        -p | --path )
          # reading $2 grabs the *next* fragment
          tomcat_path="$2"
          ;;
        -f | --filename )
          # reading $2 grabs the *next* fragment
          filename="$2"
          ;;
        -dc | --deploy-curl )
          full_file_name=$(realpath "$filename")

          eval curl -u \'"$username":"$password"\' \
          -T \""$full_file_name"\" \
          \""http://localhost:""$port"/manager/text/deploy?path="$endpoint""&update=true"\"
          ;;
        -uc | --undeploy-curl )
          eval curl -u \'"$username":"$password"\' \
           \""http://localhost:""$port"/manager/text/undeploy?path="$endpoint""&update=true"\"
          ;;
        --username=* )
          username="${1#*=}"
          ;;
        --password=* )
          password="${1#*=}"
          ;;
        --endpoint=* )
          endpoint=${1#*=}
          ;;
        --port=*)
          port=${1#*=}
    esac
    # shift to get past both the -o and the next
    shift
done