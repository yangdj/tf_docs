#! /usr/bin/env bash

export NVM_DIR="${HOME}/.nvm"

#loads nvm
[ -s "${NVM_DIR}/nvm.sh"  ] && . "${NVM_DIR}/nvm.sh"

# loads nvm bash_completion
[ -s "${NVM_DIR}/bash_completion"  ] && . "${NVM_DIR}/bash_completion"
