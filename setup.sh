#!/bin/env sh

function show_help()
{
    echo -e "\nThe following contents will to be done:\n"
    echo -e "1 Install Vundle(vim plugin) to ~/.vim/bundle/vundle/\n"
    echo -e "2 Copy configuration files to corresponding directory\n"
    echo -e "  including .aliascfg .gitconfig .vimrc\n"
}

function check_git()
{
    which git &> /dev/null
    if [ $? -ne 0 ]; then
        echo -e "#### error: can not find git here,please install git first~!\n"
        exit 0
    fi
}

function check_dir_vundle
{
    if [ -e "${HOME}/ttt/bundle/vundle/" ]; then
        echo "vundle was installed ago,setup will continue..."
    else
        echo -e "\nvundle is installing..."
        git clone https://github.com/gmarik/vundle.git ~/ttt/bundle/vundle
    fi
}

function copy_cfg_files
{
    #TODO
    if [ -e ".aliascfg" ] && [ ! -e "${HOME}/.aliascfg" -o `find -newer .aliascfg|grep "${HOME}/.aliascfg" &> /dev/null` ]; then
        cp .aliascfg ~/
    fi
    if [ -e ".gitconfig" ]; then
        cp .gitconfig ~/
    fi
    if [ -e ".vimrc" ]; then
        cp .vimrc ~/
    fi
}

show_help
echo -n "Are you sure to start? (Y/N)"
read m_start_flag

case ${m_start_flag} in
y|Y)
    check_git
    check_dir_vundle
    copy_cfg_files    
    ;;
n|N)
    exit 0
    ;;
*)
    echo -e "#### error: your input is incorrect\n"
    ;;
esac
