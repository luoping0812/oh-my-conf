#!/bin/bash 

EXEC_DIR=$(cd `dirname $0`; pwd)

# config
cp ${EXEC_DIR}/vim-conf/.vimrc ~ 
cp ${EXEC_DIR}/vim-conf/.vim ~ -rf
source ~/.vimrc

cp ${EXEC_DIR}/tmux-conf/.tmux.conf ~ 
cp ${EXEC_DIR}/tmux-conf/.tmux.conf.local ~ 
source ~/.tmux.conf

cp ${EXEC_DIR}/zsh-conf/.zshrc ~ 
source ~/.zshrc

