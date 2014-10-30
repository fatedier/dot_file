#!/bin/env sh

function show_help()
{
    echo -e "\nThe following contents will to be done:\n"
    echo -e "1 Install Vundle(vim plugin) to ~/.vim/bundle/vundle/\n"
    echo -e "2 Copy configuration files to corresponding directory\n"
    echo -e "  including .aliascfg .gitconfig .vimrc .astylerc\n"
}

show_help
echo -n "Are you sure to start? (Y/N)"
read m_start_flag

case ${m_start_flag} in
y|Y)
    echo you choose y
    ;;
n|N)
    echo you choose n
    ;;
*)
    echo you write wrong
    ;;
esac
