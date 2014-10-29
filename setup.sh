#!/bin/env sh

function fun ()
{
    echo $#
    echo $0
    echo $1
    echo $2
    echo $3
    return 3
}

fun aa bb cc dd ee ff
echo $?
