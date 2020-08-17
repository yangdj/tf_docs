#! /usr/bin/env bash

# root directory. the value can be override
export LOCAL_PROJ_HOME=/server/proj

export LOCAL_CONFIG_HOME=${LOCAL_PROJ_HOME}/tf_docs/deploy/files
export LOCAL_SHELL=$(basename $SHELL)
export LOCAL_BASHRC=~/.${LOCAL_SHELL}rc

# zsh customization
if [ "${LOCAL_SHELL}" = "zsh" ]; then
    ZSH_THEME="maran"
    plugins=(git vi-mode autojump)
    export EDITOR=vim
    export KEYTIMEOUT=1
    if [ -e "${ZSH}/oh-my-zsh.sh" ]; then
        source ${ZSH}/oh-my-zsh.sh # have to re-execute it after settging `plugins`
    fi
fi

# reload ~/.bashrc or ~/.zshrc
reload_shrc() {
    echo "source ${LOCAL_BASHRC}"
    source ${LOCAL_BASHRC}
    echo "done!"
}

# load other settings
if [ -d ${LOCAL_CONFIG_HOME}/sh ]; then
    for i in ${LOCAL_CONFIG_HOME}/sh/*.sh; do
            if [ -r $i -a `basename $i` != "bashrc.sh" ]; then
                source $i
            fi
    done
    unset i
fi