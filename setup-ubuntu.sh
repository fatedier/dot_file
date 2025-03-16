#!/bin/env bash

. ./config

now_path=$(pwd)

# Variables for colors
lc='\033['
rc='\033[0m'
cred='31m'        # red
cgreen='32m'      # green

function check_user() {
    now_user=$(whoami)
    if [ "${now_user}" != "${username}" ]; then
        echo -e "Config user is ${lc}${cred}${username}${rc}, but your username is ${lc}${cred}${now_user}${rc}"
        exit 1
    fi
}

function show_help() {
    echo -e "\n${lc}${cgreen}The following contents will be done:${rc}\n"
    echo -e "1. Install vim-plug (Vim plugin)\n"
    echo -e "2. Copy config files to corresponding directory\n"
    echo -e "   including .aliascfg .gitconfig .vimrc .zshrc .tmux.conf\n"
    echo -e "3. Install some packages using apt\n"
    echo -e "4. Your username is ${lc}${cred}${username}${rc}\n"
}

function install_vim_plug() {
    echo "Start to install vim-plug plugins..."
    vim +PlugInstall +qall
    echo -e "${lc}${cgreen}Install vim-plug success${rc}"
}

function copy_cfg_files() {
    echo ""
    local files=(".aliascfg" ".gitconfig" ".vimrc" ".zshrc" ".tmux.conf")
    for file in "${files[@]}"; do
        if [ -e "${file}" ]; then
            cp -f "${file}" ~/
            echo "Copied ${file} to ~/"
        fi
    done

    # Ensure .zshrc includes aliascfg
    grep "aliascfg" ~/.zshrc > /dev/null
    if [ $? != 0 ]; then
        cp -f .zshrc ~/
        echo "Copied .zshrc to ~/"
    fi

    echo -e "${lc}${cgreen}Copy config files done${rc}"
}

function add_include_to_bashrc() {
    echo -e "\nCheck if .bashrc includes .aliascfg..."
    grep "~/.aliascfg" ~/.bashrc > /dev/null
    if [ $? != 0 ]; then
        echo -e "\n# Include files\nif [ -f ~/.aliascfg ]; then\n    . ~/.aliascfg\nfi" >> ~/.bashrc
        echo -e "${lc}${cgreen}Added .aliascfg to .bashrc${rc}"
    else
        echo ".aliascfg is already included in .bashrc"
    fi

    source ~/.bashrc
}

function install_package() {
    # Update package list
    sudo apt update

    # Define packages to install
    local packages=(
        git
        vim
        build-essential      # Includes gcc and g++
        golang-go            # Go programming language
        exuberant-ctags      # ctags
        zsh
        autojump
        tmux
        tree
        wget
        silversearcher-ag    # the_silver_searcher
        curl
        bison
    )

    # Install each package if not already installed
    for pkg in "${packages[@]}"; do
        echo "Checking ${pkg}..."
        if dpkg -s "${pkg}" &> /dev/null; then
            echo "${pkg} is already installed"
        else
            echo "${pkg} not found, installing..."
            sudo apt install -y "${pkg}"
            if [ $? -ne 0 ]; then
                echo -e "${lc}${cred}Install ${pkg} failed${rc}"
                exit 1
            fi
            echo -e "${lc}${cgreen}Successfully installed ${pkg}${rc}"
        fi
    done

    # Verify Go installation
    if ! command -v go &> /dev/null; then
        echo -e "${lc}${cred}Go installation via apt failed or Go is not in PATH${rc}"
        exit 1
    else
        echo -e "${lc}${cgreen}Go is successfully installed and available${rc}"
    fi
}

function create_dir() {
    local dirs=(
        "${HOME}/local/git_fatedier"
        "${HOME}/go_projects/src"
        "${HOME}/tmp"
    )

    for dir in "${dirs[@]}"; do
        if [ ! -d "${dir}" ]; then
            mkdir -p "${dir}"
            if [ $? -ne 0 ]; then
                echo -e "${lc}${cred}Failed to create directory ${dir}${rc}"
            else
                echo -e "${lc}${cgreen}Successfully created directory ${dir}${rc}"
            fi
        else
            echo "Directory ${dir} already exists"
        fi
    done
}

function download() {
    cd "${HOME}/local/git_fatedier" || exit

    # fatedier-tools
    if [ ! -d "fatedier-tools" ]; then
        echo 'Start downloading fatedier-tools...'
        git clone https://github.com/fatedier/fatedier-tools.git
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Download fatedier-tools failed${rc}"
        else
            echo -e "${lc}${cgreen}Download fatedier-tools success${rc}"
            # Compile some tools
            cd fatedier-tools/astyle && make
            cd ../../
        fi
    fi

    # dot_file
    if [ ! -d "dot_file" ]; then
        echo 'Start downloading dot_file...'
        git clone https://github.com/fatedier/dot_file.git
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Download dot_file failed${rc}"
        else
            echo -e "${lc}${cgreen}Download dot_file success${rc}"
        fi
    fi

    # oh-my-zsh
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        echo 'Start downloading oh-my-zsh...'
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install oh-my-zsh failed${rc}"
            exit 1
        fi
        echo -e "${lc}${cgreen}Successfully installed oh-my-zsh${rc}"
    fi

    cd "${now_path}" || exit

    # tmux plugin tpm
    if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Clone tpm plugin failed${rc}"
        else
            echo -e "${lc}${cgreen}Successfully cloned tpm plugin${rc}"
        fi
    fi
}

function extra() {
    # gvm
    if [ ! -d "${HOME}/.gvm" ]; then
        zsh < <(curl -s -S -L https://raw.githubusercontent.com/fatedier/gvm/self/binscripts/gvm-installer)
        if [ $? -ne 0 ]; then
            echo -e "${lc}${cred}Install gvm failed${rc}"
            exit 1
        fi
        echo -e "${lc}${cgreen}Successfully installed gvm${rc}"
    fi
}

function use_zsh() {
    sudo chsh -s "$(which zsh)" "${username}"
    echo -e "${lc}${cgreen}You need to relogin to use zsh${rc}"
}

# Check current user
check_user

# Show help information
show_help

# Confirm to start
echo -ne "Are you sure to start? Make sure you have the ${lc}${cred}sudo${rc} permissions ${lc}${cred}without password${rc} (Y/N): "
read -r m_start_flag

case ${m_start_flag} in
    y|Y)
        install_package
        create_dir
        download
        copy_cfg_files

        # Execute actions based on the shell used
        if [ "${use_shell}" = "bash" ]; then
            add_include_to_bashrc
        else
            use_zsh
        fi

        extra

        # Install vim plugins
        install_vim_plug

        echo "Setup over"
        ;;
    n|N)
        exit 0
        ;;
    *)
        echo -e "${lc}${cred}#### error: your input is incorrect${rc}\n"
        ;;
esac
