#!/bin/env bash

function show_help()
{
    echo -e "\nThe following contents will to be done:\n"
    echo -e "1 Install Vundle(vim plugin) to ~/.vim/bundle/vundle/\n"
    echo -e "2 Copy config files to corresponding directory\n"
    echo -e "  including .aliascfg .gitconfig .vimrc\n"
}

function check_dir_vundle
{
    if [ -e "${HOME}/.vim/bundle/vundle/" ]; then
        echo "Vundle was already installed,setup will continue..."
    else
        echo -e "\nVundle is installing..."
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        echo "Start to install plugin by vundle..."
        vim +BundleInstall +qa
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

function add_include_to_bash_profile
{
    echo -e "\nCheck if .bash_profile including .aliascfg..."
    grep "~/.aliascfg" ~/.bash_profile &>/dev/null
    if [ $? != 0 ]; then
        echo -e "\n# Include files\nif [ -f ~/.aliascfg ]; then\n    . ~/.aliascfg\nfi" >> ~/.bash_profile
        echo "File .bash_profile doesn't include .aliascfg, add it success"
    else
        echo ".aliascfg is already included"
    fi

    source ~/.bash_profile
}

function install_package
{
    # epel
    echo "check epel-release..."
    rpm -qa|grep epel-release > /dev/null
    if [ $? -ne 0 ]; then
        echo "epel-release is not found, to install..."
        sudo yum install -y epel-release
        if [ $? -ne 0 ]; then
            echo "Install epel-release failed"
            exit -1
        fi
        echo "Install epel-release success"
        sudo yum makecache
    fi
    # git
    echo "check git..."
    which git &> /dev/null
    if [ $? -ne 0 ]; then
        echo "git is not found, to install..."
        sudo yum install -y git
        if [ $? -ne 0 ]; then
            echo "Install git failed"
            exit -1
        fi
        echo "Install git success"
    fi
    # vim
    echo "check vim..."
    which vim &> /dev/null
    if [ $? -ne 0 ]; then
        echo "vim is not found, to install..."
        sudo yum install -y vim
        if [ $? -ne 0 ]; then
            echo "Install vim failed"
            exit -1
        fi
        echo "Install vim success"
    fi
    # gcc-c++
    echo "check gcc-c++..."
    which g++ &> /dev/null
    if [ $? -ne 0 ]; then
        echo "g++ is not found, to install..."
        sudo yum install -y gcc-c++
        if [ $? -ne 0 ]; then
            echo "Install gcc-c++ failed"
            exit -1
        fi
        echo "Install gcc-c++ success"
    fi
    # golang
    echo "check golang..."
    which go &> /dev/null
    if [ $? -ne 0 ]; then
        echo "golang is not found, to install..."
        sudo yum install -y golang
        if [ $? -ne 0 ]; then
            echo "Install golang failed"
            exit -1
        fi
        echo "Install golang success"
    fi 
}

function create_dir()
{
    # git_fatedier
    if [ ! -d "${HOME}/local/git_fatedier" ]; then
        echo "mkdir -p {HOME}/local/git_fatedier"
        mkdir -p ~/local/git_fatedier
    fi
}

function download()
{
    cd ~/local/git_fatedier
    # fatedier-tools
    if [ ! -d "${HOME}/local/git_fatedier/fatedier-tools" ]; then
        echo 'start download fatedier-tools...'
        git clone https://github.com/fatedier/fatedier-tools.git
        # compile some tools
        cd ${HOME}/local/git_fatedier/fatedier-tools/astyle && gmake
    fi
    # dot_file
    if [ ! -d "${HOME}/local/git_fatedier/dot_file" ]; then
        echo 'start download dot_file...'
        git clone https://github.com/fatedier/dot_file.git
    fi
}

show_help
echo -n "Are you sure to start? Make sure you have the sudo permissions (Y/N)"
read m_start_flag

case ${m_start_flag} in
y|Y)
    install_package
    check_dir_vundle
    copy_cfg_files
    add_include_to_bash_profile
    create_dir
    download
    ;;
n|N)
    exit 0
    ;;
*)
    echo -e "#### error: your input is incorrect\n"
    ;;
esac
