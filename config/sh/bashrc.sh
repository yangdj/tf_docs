#! /usr/bin/env bash

export PATH=/sbin:${PATH}

case $(uname -s) in
    Darwin|Linux) 
        export MY_OPERATING_SYSTEM_TYPE=NIX
        export MY_TF_HOME=~/.tfft
        ;;
    MINGW*|MSYS_NT*)
        export MY_OPERATING_SYSTEM_TYPE=windows
        export MY_TF_HOME=/f/tfft
        ;;
    *) 
        export MY_OPERATING_SYSTEM_TYPE=unknown
        ;;
esac

export MY_SOFTWARE_HOME=~/.MY_SOFTWARE
export MY_SRC_HOME=${MY_SOFTWARE_HOME}/src
export MY_BUILD_HOME=${MY_SOFTWARE_HOME}/build
export MY_CONFIG_HOME=${MY_SOFTWARE_HOME}/config

export MY_SHRC_FILE=${MY_CONFIG_HOME}/sh/bashrc.sh
export MY_SHRC_BASENAME=$(basename ${MY_SHRC_FILE})
export MY_SHELL=$(basename $SHELL)

# get shell source name, e.g., ~/.bashrc or ~/.zshrc
export MY_BASHRC_FILE=~/.${MY_SHELL}rc

update_shrc() {
    echo "source ${MY_BASHRC_FILE}"
    source ${MY_BASHRC_FILE}
    echo "done!"
}

# zsh config
if [ "${MY_SHELL}" = "zsh" ]; then
    ZSH_THEME="maran"
    plugins=(git vi-mode autojump)
    export EDITOR=vim
    export KEYTIMEOUT=1
    if [ -e "${ZSH}/oh-my-zsh.sh" ]; then
        source $ZSH/oh-my-zsh.sh # have to re-execute it after settging `plugins`
    fi
fi

if [ -r ${MY_CONFIG_HOME}/sh/local.sh ]; then
    source ${MY_CONFIG_HOME}/sh/local.sh
fi

export MY_DATA_HOME=${MY_LOCAL_DATA_HOME:-/data}
export MY_PROJECT_HOME=${MY_DATA_HOME}/proj
export MY_DATABASE_HOME=${MY_PROJECT_HOME}/database

if [ -d ${MY_CONFIG_HOME}/sh ]; then
    for i in ${MY_CONFIG_HOME}/sh/*.sh; do
            if [ -r $i -a `basename $i` != "${MY_SHRC_BASENAME}" ]; then
                source $i
            fi
    done
    unset i
fi
