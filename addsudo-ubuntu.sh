#!/bin/bash

# 加载配置文件
. ./config

# 颜色变量
lc='\033['
rc='\033[0m'
cred='31m'      # 红色
cgreen='32m'    # 绿色

# 获取当前用户
now_user=$(whoami)

# 检查是否以 root 用户运行
if [ "${now_user}" != "root" ]; then
    echo -e "${lc}${cred}You should run this script as root.${rc}"
    exit 1
fi

# 检查用户名是否已定义
if [ -z "${username}" ]; then
    echo -e "${lc}${cred}Username is not defined in config file.${rc}"
    exit 1
fi

# 添加用户，如果用户不存在
if id "${username}" &>/dev/null; then
    echo -e "${lc}${cgreen}User '${username}' already exists.${rc}"
else
    adduser --disabled-password --gecos "" "${username}"
    if [ $? -ne 0 ]; then
        echo -e "${lc}${cred}Failed to add user '${username}'.${rc}"
        exit 1
    fi
    echo -e "${lc}${cgreen}User '${username}' added successfully.${rc}"
fi

# 设置 sudo 权限，无需密码
sudoers_file="/etc/sudoers.d/${username}"
if [ -f "${sudoers_file}" ]; then
    echo -e "${lc}${cgreen}Sudoers file for '${username}' already exists.${rc}"
else
    echo -e "${username}\tALL=(ALL)\tNOPASSWD: ALL" > "${sudoers_file}"
    chmod 440 "${sudoers_file}"
    if [ $? -ne 0 ]; then
        echo -e "${lc}${cred}Failed to set permissions for '${sudoers_file}'.${rc}"
        exit 1
    fi
    echo -e "${lc}${cgreen}Added sudo permission for user '${username}'.${rc}"
fi
