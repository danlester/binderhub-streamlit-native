#!/bin/bash

# For a command line such as:
# "/home/jovyan/entrypoint.sh jupyter notebook --ip 0.0.0.0 --port 59537 --NotebookApp.custom_display_url=http://127.0.0.1:59537"
# strip out most args, just pass on the port


collect_port=0
port="8888"

for var in "$@"
do
    echo "$var"

    if [ "$collect_port" == "1" ]; then
       echo "Collecting external port $var"
       port=$var
       collect_port=0
    fi

    if [ "$var" == "--port" ]; then
       collect_port=1
    fi
done

destport=$((port + 1))

echo "Using internal port $destport"

jhsingle-native-proxy --destport $destport streamlit hello {--}server.port {port} {--}server.headless True {--}server.enableCORS False --port $port

