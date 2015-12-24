#!/bin/env bash

# config
use_shell='zsh'     # bash or zsh
now_path=`pwd`

# var
lc='\033['
rc='\033[0m'
cred='31m'        # red
cgreen='32m'        # green

function show_help()
{
    echo -e "\n${lc}${cgreen}The following contents will to be done:${rc}\n"
    echo -e "1 Install Vundle(vim plugin) to ~/.vim/bundle/vundle/\n"
    echo -e "2 Copy config files to corresponding directory\n"
    echo -e "  including .aliascfg .gitconfig .vimrc .zshrc .tmux.conf\n"
    echo -e "3 Download some packages using yum\n"
}

function check_dir_vundle
{
    if [ -e "${HOME}/.vim/bundle/vundle/" ]; then
        echo -e "${lc}${cgreen}Vundle was already installed,setup will continue...${rc}"
    else
        echo -e "\nVundle is installing..."
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        echo "Start to install plugin by vundle..."
        vim +BundleInstall +qa
        echo -e "${lc}${cgreen}Install vundle success${rc}"
    fi
}

function copy_cfg_files
{
    echo ""
    # .aliascfg
    find ~ -maxdepth 1 -newer ".aliascfg" | grep "${HOME}/.aliascfg" &>/dev/null
    if [ -e ".aliascfg" -a $? != 0 ]; then
        cp -f .aliascfg ~/
        echo "cp -f .aliascfg ~/"
    fi

    # .gitconfig
    find ~ -maxdepth 1 -newer ".gitconfig" | grep "${HOME}/.gitconfig" &>/dev/null
    if [ -e ".gitconfig" -a $? != 0 ]; then
        cp -f .gitconfig ~/
        echo "cp -f .gitconfig ~/"
    fi

    # .vimrc
    find ~ -maxdepth 1 -newer ".vimrc" | grep "${HOME}/.vimrc" &>/dev/null
    if [ -e ".vimrc" -a $? != 0 ]; then
        cp -f .vimrc ~/
        echo "cp -f .vimrc ~/"
    fi

    # .zshrc
    find ~ -maxdepth 1 -newer ".zshrc" | grep "${HOME}/.zshrc" &>/dev/null
    if [ -e ".zshrc" -a $? != 0 ]; then
        cp -f .zshrc ~/
        echo "cp -f .zshrc ~/"
    fi
    cat ~/.zshrc | grep "aliascfg" > /dev/null
    if [ $? != 0 ]; then
        cp -f .zshrc ~/
        echo "cp -f .zshrc ~/"
    fi

    # .tmux.conf
    find ~ -maxdepth 1 -newer ".tmux.conf" | grep "${HOME}/.tmux.conf" &>/dev/null
    if [ -e ".tmux.conf" -a $? != 0 ]; then
        cp -f .tmux.conf ~/
        echo "cp -f .tmux.conf ~/"
    fi
    echo -e "${lc}${cgreen}Copy config files down${rc}"
}

function add_include_to_bash_profile
{
    echo -e "\nCheck if .bash_profile including .aliascfg..."
    grep "~/.aliascfg" ~/.bash_profile &>/dev/null
    if [ $? != 0 ]; then
        echo -e "\n# Include files\nif [ -f ~/.aliascfg ]; then\n    . ~/.aliascfg\nfi" >> ~/.bash_profile
        echo -e "${lc}${cgreen}File .bash_profile doesn't include .aliascfg, add it success${rc}"
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
            echo -e "${lc}${cred}Install epel-release failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install epel-release success${rc}"
        sudo yum makecache
    fi
    # git
    echo "check git..."
    which git &> /dev/null
    if [ $? -ne 0 ]; then
        echo "git is not found, to install..."
        sudo yum install -y git
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install git failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install git success"
    fi
    # vim
    echo "check vim..."
    which vim &> /dev/null
    if [ $? -ne 0 ]; then
        echo "vim is not found, to install..."
        sudo yum install -y vim
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install vim failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install vim success${rc}"
    fi
    # gcc-c++
    echo "check gcc-c++..."
    which g++ &> /dev/null
    if [ $? -ne 0 ]; then
        echo "g++ is not found, to install..."
        sudo yum install -y gcc-c++
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install gcc-c++ failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install gcc-c++ success${rc}"
    fi
    # golang
    echo "check golang..."
    which go &> /dev/null
    if [ $? -ne 0 ]; then
        echo "golang is not found, to install..."
        sudo yum install -y golang
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install golang failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install golang success${rc}"
    fi 
    # ctags
    echo "check ctags..."
    which ctags &> /dev/null
    if [ $? -ne 0 ]; then
        echo "ctags is not found, to install..."
        sudo yum install -y ctags 
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install ctags failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install ctags success${rc}"
    fi
    # zsh
    echo "check zsh..."
    which zsh &> /dev/null
    if [ $? -ne 0 ]; then
        echo "zsh is not found, to install..."
        sudo yum install -y zsh
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install zsh failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install zsh success${rc}"
    fi
    # autojump-zsh
    echo "check autojump-zsh..."
    rpm -qa|grep autojump-zsh >/dev/null
    if [ $? -ne 0 ]; then
        echo "autojump-zsh is not found, to install..."
        sudo yum install -y autojump-zsh
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install autojump-zsh failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install autojump-zsh success${rc}"
    fi
    # tmux
    echo "check tmux..."
    which tmux &> /dev/null
    if [ $? -ne 0 ]; then
        echo "tmux is not found, to install..."
        sudo yum install -y tmux
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install tmux failed${rc}"
            exit -1
        fi
        echo -e "${lc}${cgreen}Install tmux success${rc}"
    fi
}

function create_dir()
{
    # git_fatedier
    if [ ! -d "${HOME}/local/git_fatedier" ]; then
        mkdir -p ${HOME}/local/git_fatedier
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}mkdir -p ${HOME}/local/git_fatedier failed${rc}"
        else
            echo -e "${lc}${cgreen}mkdir -p ${HOME}/local/git_fatedier success${rc}"
        fi
    fi
    # golang directory
    if [ ! -d "${HOME}/go_projects/src" ]; then
        mkdir -p ${HOME}/go_projects/src
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}mkdir -p ${HOME}/go_projects/src failed${rc}"
        else
            echo -e "${lc}${cgreen}mkdir -p ${HOME}/go_projects/src success${rc}"
        fi
    fi
}

function download()
{
    cd ${HOME}/local/git_fatedier
    # fatedier-tools
    if [ ! -d "${HOME}/local/git_fatedier/fatedier-tools" ]; then
        echo 'start download fatedier-tools...'
        git clone https://github.com/fatedier/fatedier-tools.git
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Download fatedier-tools failed${rc}"
        else
            echo -e "${lc}${cgreen}Download fatedier-tools success${rc}"
        fi
        # compile some tools
        cd ${HOME}/local/git_fatedier/fatedier-tools/astyle && make
    fi
    cd ${HOME}/local/git_fatedier
    # dot_file
    if [ ! -d "${HOME}/local/git_fatedier/dot_file" ]; then
        echo 'start download dot_file...'
        git clone https://github.com/fatedier/dot_file.git
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Download dot_file failed${rc}"
        else
            echo -e "${lc}${cgreen}Download dot_file success${rc}"
        fi
    fi
    # oh-my-zsh
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        echo 'start download oh-my-zsh...'
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        echo -e "${lc}${cgreen}Download oh-my-zsh over${rc}"
    fi
    cd ${now_path}
}

function use_zsh()
{
    sudo chsh -s /bin/zsh wcl
    # source ~/.zshrc
    echo -e "${lc}${cgreen}You need to relogin to use zsh${rc}"
}

show_help
echo -ne "Are you sure to start? Make sure you have the ${lc}${cred}sudo${rc} permissions (Y/N)"
read m_start_flag

case ${m_start_flag} in
y|Y)
    # 通过yum安装所需的包
    install_package
    # 创建需要用到的目录
    create_dir
    # 下载相关文件或项目
    download
    # 将配置文件放到指定目录下
    copy_cfg_files
    # 使用bash或者zsh执行不同的操作
    if [ "${use_shell}"X = "bash" ]; then
        add_include_to_bash_profile
    else
        use_zsh
    fi
    # vim相关
    check_dir_vundle
    echo "Setup over"
    ;;
n|N)
    exit 0
    ;;
*)
    echo -e "${lc}${cred}#### error: your input is incorrect${rc}\n"
    ;;
esac
