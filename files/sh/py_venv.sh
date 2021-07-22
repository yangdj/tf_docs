#! /usr/bin/env bash

export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
export LOCAL_PY_ENV_HOME=${LOCAL_PROJ_HOME}/.env

# avoid default setting
export PYTHONPATH= 

help_py_env() {
    cat <<-_EOF_

here are the functions to operate python virtual environment:

    help_py_env
    home_py_env
    exist_py_env
    init_py_env
    clear_py_env
    list_py_env
    create_py_env
    activate_py_env
    remove_py_env

_EOF_
}

home_py_env() {
    cat <<-_EOF_
the directory to hold python virtual environments is:
    ${LOCAL_PY_ENV_HOME}

use other directory to hold virtual enviroments by setting environment variable
"LOCAL_PY_ENV_HOME"

create the directory using:
    init_py_env

and clear the direcotry using:
    clear_py_env
_EOF_
}

_exist_py_env() {
    if [ -d "${LOCAL_PY_ENV_HOME}" ]; then
        return 0
    else
        return 1
    fi
}

exist_py_env() {
    if _exist_py_env; then
        echo -e "the '${LOCAL_PY_ENV_HOME}' directory is existing.\n"
    else
        echo -e "the '${LOCAL_PY_ENV_HOME}' directory is not existing.\n"
        home_py_env
    fi
}

init_py_env() {
    if ! _exist_py_env; then
        mkdir -p ${LOCAL_PY_ENV_HOME}
        echo "the holding directory has been created in the ${LOCAL_PY_ENV_HOME}"
    else
        exist_py_env
    fi
}

clear_py_env() {
    if _exist_py_env; then
        rm -rf ${LOCAL_PY_ENV_HOME}
        echo "the directory "${LOCAL_PY_ENV_HOME}" has been cleard"
    else
       exist_py_env 
    fi
}

list_py_env() {
    ! _exist_py_env && exist_py_env && return 1
    if [ "$(ls -A ${LOCAL_PY_ENV_HOME})" ]; then
        echo -e "\nthe followings are the existing virtual environment:\n"
        for i in ${LOCAL_PY_ENV_HOME}/*; do
            echo $(basename $i)
        done
    else
        echo -e "there is no virtual environment now, you can create one \
            using:\n\n\tcreate_py_env\tyour_virtual_name\n"
    fi
}

create_py_env() {
    ! _exist_py_env && exist_py_env && return 1
    if [ -z "$1" ]; then
        echo "please supply the virtual name to created! for example:\n"
        echo "\tcreate_py_env helloworld\n"
    elif [ -d "${LOCAL_PY_ENV_HOME}/$1" ]; then
        echo "the virtual name '$1' has bee exsiting! please supply other \
            name to create or remove the virtual first!"
    else
        python3 -m venv ${LOCAL_PY_ENV_HOME}/$1
        echo "the $1 virtual environment has been created!"
        list_py_env
    fi
}

activate_py_env() {
    ! _exist_py_env && exist_py_env && return 1
    if [ -z "$1" ]; then
        echo "please supply the virtual name to activate!"
        list_py_env
    elif [ ! -d "${LOCAL_PY_ENV_HOME}/$1" ]; then
        echo "there is no virtual name called: $1"
        list_py_env
    else
        if [ -n "${_OLD_VIRTUAL_PATH}" ]; then 
            # _OLD_VIRTUAL_PATH from bin/activate file
            deactivate
        fi
        source ${LOCAL_PY_ENV_HOME}/$1/bin/activate
    fi
}

remove_py_env() {
    ! _exist_py_env && exist_py_env && return 1
    if [ -z "$1" ]; then
        echo "please supply the virtual name to remove!"
        list_py_env
    elif [ ! -d "${LOCAL_PY_ENV_HOME}/$1" ]; then
        echo "there is no virtual name called: $1"
        list_py_env
    else
        rm -rf "${LOCAL_PY_ENV_HOME}/$1"
        echo "the $1 virtual environment has been removed!"
        list_py_env
    fi
}
