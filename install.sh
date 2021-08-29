#!/bin/bash 

echo "install begin"

tool_set=(python3 python3-pip make gcc zsh tmux cscope ctags zplug fzf)

PKG_TOOL="apt-get"

# sudo ${PKG_TOOL} update

# for element in ${tool_set[@]}
# do
#     cmd="sudo ${PKG_TOOL} install ${element}"
#     echo ""
#     echo ">>>   ${cmd}"
#     $cmd
# done


# 通过git下载源码
git_set=(ryanoasis/nerd-fonts ohmyzsh/ohmyzsh tmux-plugins/tpm)
git_src_dir=$HOME/tmp

if [ ! -d $git_src_dir ]; then
    mkdir $git_src_dir 
fi

# cd $git_src_dir 

# for element in ${git_set[@]}
# do
#     cmd="git clone git@github.com:${element}.git"
#     echo ""
#     echo ">>>   ${cmd}"
#     $cmd
# done

#源码安装



if [ -d $git_src_dir/nerd-fonts ]; then
    if [ ! -d $HOME/.local/share/fonts/NerdFonts ];  then
        $bash "$git_src_dir/nerd-fonts/install.sh"
    fi
fi

if [ -d $git_src_dir/ohmyzsh/tools ]; then
    if [ ! -d $HOME/.oh-my-zsh ];  then
        $bash "$git_src_dir/ohmyzsh/tools/install.sh"
    fi
fi

if [ -d $git_src_dir/tpm ]; then
    if [ ! -d $HOME/.tmux/plugins/tpm ];  then
        mkdir $HOME/.tmux
        mkdir $HOME/.tmux/plugins
        cp $git_src_dir/tpm  $HOME/.tmux/plugins/ -r

    fi
fi


sudo pip install mkdocs

echo ""
echo "install end"