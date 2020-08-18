#! /usr/bin/env bash

export LOCAL_AIRFLOW_PROJECT_HOME=${LOCAL_PROJ_HOME}/airflow

help_airflow() {
    cat <<-_EOF_

here are the functions to help operate airflow project:

    help_airflow
    home_airflow - echo dir to hold your airflow projects
    init_airflow - create dir to store your airflow projects
    clear_airflow - remove the dir storing your airflow projects
    list_airflow
    create_airflow
    activate_airflow
    remove_airflow
    create_airflow_rabbitmq_user

_EOF_
}

home_airflow() {
   echo -e "\nthe dir to hold your airflow projects is:\n\n\t${LOCAL_AIRFLOW_PROJECT_HOME}\n"
}

init_airflow() {
    echo "airflow projects will be stored in the directory: ${LOCAL_AIRFLOW_PROJECT_HOME}"
    [ ! -d ${LOCAL_AIRFLOW_PROJECT_HOME} ] && mkdir ${LOCAL_AIRFLOW_PROJECT_HOME}
}

clear_airflow() {
    [ -d ${LOCAL_AIRFLOW_PROJECT_HOME} ] && rm -rf ${LOCAL_AIRFLOW_PROJECT_HOME}
}

list_airflow() {
    if [ "$(ls -A ${LOCAL_AIRFLOW_PROJECT_HOME})" ]; then
        echo -e "\nthe followings are the existing airflow project:\n"
        for i in ${LOCAL_AIRFLOW_PROJECT_HOME}/*; do
            echo $(basename $i)
        done
    else
        echo -e "there is no airflow project now, you can create one using:\n\n\tcreate_airflow\tyour_airflow_name\n"
    fi
}

create_airflow() {
    if [ -z "$1" ]; then
        echo "please supply an airflow project name to created!"
    elif [ -d "{LOCAL_AIRFLOW_PROJECT_HOME}/$1" ]; then
        echo "the project name has bee exsiting! please supply other name to create or remove the project first!"
    else
        export AIRFLOW_HOME=${LOCAL_AIRFLOW_PROJECT_HOME}/$1
        activate_py_env airflow
        airflow initdb
        echo -e "\nthe $1 airflow project has been created and AIRFLOW_HOME has been changed to $1"
        list_airflow
    fi
}

activate_airflow() {
    if [ -z "$1" ]; then
        echo "please supply the airflow project name to activate!"
        list_airflow
    elif [ ! -d "${LOCAL_AIRFLOW_PROJECT_HOME}/$1" ]; then
        echo "there is no airflow project name called: $1"
        list_airflow
    else
        export AIRFLOW_HOME=${LOCAL_AIRFLOW_PROJECT_HOME}/$1
        export PYTHONPATH=${AIRFLOW_HOME}:${AIRFLOW_HOME}/plugins:${PYTHONPATH}
        echo "AIRFLOW_HOME has been changed to $1"
    fi
}

remove_airflow() {
    if [ -z "$1" ]; then
        echo "please supply the airflow project name to remove!"
        list_airflow
    elif [ ! -d "${LOCAL_AIRFLOW_PROJECT_HOME}/$1" ]; then
        echo "there is no airflow project called: $1"
        list_airflow
    else
        rm -rf "${LOCAL_AIRFLOW_PROJECT_HOME}/$1"
        echo "the $1 airflow project has been removed!"
        list_airflow
    fi
}

restart_airflow_server() {
    sudo systemctl restart airflow-webserver
    sudo systemctl restart airflow-scheduler
    sudo systemctl restart airflow-worker
    sudo systemctl restart airflow-flower
}

start_airflow_server() {
    sudo systemctl start airflow-webserver
    sudo systemctl start airflow-scheduler
    sudo systemctl start airflow-worker
    sudo systemctl start airflow-flower
}

stop_airflow_server() {
    sudo systemctl stop airflow-webserver
    sudo systemctl stop airflow-scheduler
    sudo systemctl stop airflow-worker
    sudo systemctl stop airflow-flower
}