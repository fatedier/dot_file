#!/bin/env sh

function show_help()
{
    echo -e "\nThe following contents will to be done:\n"
    echo -e "1 Install Vundle(vim plugin) to ~/.vim/bundle/vundle/\n"
    echo -e "2 Copy config files to corresponding directory\n"
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
    if [ -e "${HOME}/.vim/bundle/vundle/" ]; then
        echo "Vundle was already installed,setup will continue..."
    else
        echo -e "\nVundle is installing..."
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    fi
}

function copy_cfg_files
{
    echo ""
    find ~ -maxdepth 1 -newer ".aliascfg" | grep "${HOME}/.aliascfg" &>/dev/null
    if [ -e ".aliascfg" -a $? != 0 ]; then
        cp .aliascfg ~/
        echo "cp .aliascfg ~/"
    fi

    find ~ -maxdepth 1 -newer ".gitconfig" | grep "${HOME}/.gitconfig" &>/dev/null
    if [ -e ".gitconfig" -a $? != 0 ]; then
        cp .gitconfig ~/
        echo "cp .gitconfig ~/"
    fi

    find ~ -maxdepth 1 -newer ".vimrc" | grep "${HOME}/.vimrc" &>/dev/null
    if [ -e ".vimrc" -a $? != 0 ]; then
        cp .vimrc ~/
        echo "cp .vimrc ~/"
    fi

    echo "Copy config files down"
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
