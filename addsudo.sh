#!/bin/env sh

. ./config

# var
lc='\033['
rc='\033[0m'
cred='31m'
cgreen='32m'

now_user=`whoami`
if [ "${now_user}X" != "root"X ]; then
    echo -e "${lc}${cred}you should be the root user${rc}"
    exit -1
fi

id ${username} &>/dev/null
if [ $? -eq 0 ]; then
    echo -e "${lc}${cgreen}user ${username} already exists, skipping creation${rc}"
else
    useradd ${useradd}
fi

chmod o+w /etc/sudoers
cat /etc/sudoers | grep ${username}$'\t'ALL=\(ALL\) &>/dev/null
if [ $? != 0 ]; then
    echo -e "${username}\tALL=(ALL)\tNOPASSWD: ALL" >> /etc/sudoers
    echo -e "add sudo permission for user ${lc}${cred}${username}${rc}"
else
    echo -e "${lc}${cgreen}user ${username} already exist${rc}"
fi
chmod o-w /etc/sudoers
