#!/bin/bash 

EXEC_DIR=$(cd `dirname $0`; pwd)
PKG_TOOL="apt-get"

tool_set=(python3 python3-pip make cmake gcc zsh tmux zplug fzf thefuck autojump vim-gtk3 manpages-zh)
git_set=(ohmyzsh/ohmyzsh tmux-plugins/tpm ryanoasis/nerd-fonts MaskRay/ccls) 
src_dir=$HOME/tmp

# config
if [ ! -d ~/.vim ]; then
    cp ${EXEC_DIR}/vim-conf/.vimrc ~ 
    cp ${EXEC_DIR}/vim-conf/.vim ~ -r
    source ~/.vimrc
fi

if [ ! -f ~/.tmux.conf ]; then
    cp ${EXEC_DIR}/tmux-conf/.tmux.conf ~ 
    cp ${EXEC_DIR}/tmux-conf/.tmux.conf.local ~ 
    source ~/.tmux.conf
fi

if [ ! -f ~/.zshrc ]; then
    cp ${EXEC_DIR}/zsh-conf/.zshrc ~ 
    source ~/.zshrc
fi

# tool
sudo ${PKG_TOOL} update
for element in ${tool_set[@]}
do
    cmd="sudo ${PKG_TOOL} install ${element}"
    echo ""
    echo ">>>   ${cmd}"
    $cmd
done

# src 
if [ ! -d $src_dir ]; then
    mkdir $src_dir 
fi

cd $src_dir 
for element in ${git_set[@]}
do
    array=(${element//// })
    if [ ! -d ${array[1]} ]; then
        if [ ! -d $src_dir/${element} ]; then
            cmd="git clone git@github.com:${element}.git"
            echo ""
            echo ">>>   ${cmd}"
            $cmd
        fi
    fi
done

if [ -d $src_dir/nerd-fonts ]; then
    if [ ! -d $HOME/.local/share/fonts/NerdFonts ];  then
        $bash "$src_dir/nerd-fonts/install.sh"
    fi
fi

if [ -d $src_dir/ohmyzsh/tools ]; then
    if [ ! -d $HOME/.oh-my-zsh ];  then
        $bash "$src_dir/ohmyzsh/tools/install.sh"
    fi
fi

if [ -d $src_dir/tpm ]; then
    if [ ! -d $HOME/.tmux/plugins/tpm ];  then
        mkdir $HOME/.tmux
        mkdir $HOME/.tmux/plugins
        cp $src_dir/tpm  $HOME/.tmux/plugins/ -r
    fi
fi

if [ -d $src_dir/ccls ]; then
    if [ ! -f $src_dir/ccls/build/Release/ccls ];  then
        cd ccls
        git submodule update --init --recursive
        cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx
        cmake --build Release
    fi
fi

# gtags
# pip install pygments
# sudo apt build-dep global
# sudo apt install libncurses5-dev libncursesw5-dev
# wget https://ftp.gnu.org/pub/gnu/global/global-6.6.7.tar.gz ${src_dir} 
# tar zxvf global-6.6.7.tar.gz
# cd global-6.6.7
# ./configure --with-sqlite3   # gtags可以使用Sqlite3作为数据库, 在编译时需要加这个参数
# make -j4
# sudo make install
# mkdir ~/.gtags
# cp gtags.conf ~/.gtags/


# other
sudo pip install mkdocs

# alias
echo "alias cman='man -M /usr/share/man/zh_CN' " >> .bash_profile
echo "alias clangd='clangd-12' " >> .bash_profile
source ~/.bash_profile

