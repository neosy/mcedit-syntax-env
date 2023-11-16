#!/bin/bash

# Install ENV syntax for mcedit
# Author: Neosy <neosy.dev@gmail.com>
#
#==================================
# Version 0.1
#==================================
#
SCRIPT_PATH=$(dirname $(readlink -e $0))

SYNTAX_FILE_NAME="Syntax"
SYNTAX_PATH="/usr/share/mc/syntax"
SYNTAX_FILE="${SYNTAX_PATH}/${SYNTAX_FILE_NAME}"

SYNTAX_MY_PATH="${SCRIPT_PATH}/syntax"
SYNTAX_ADD_FILE="$SYNTAX_MY_PATH/${SYNTAX_FILE_NAME}"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Copy files *.syntax to Syntax
cp $SYNTAX_MY_PATH/*.syntax $SYNTAX_PATH

row=`cat "$SYNTAX_FILE" | grep -E '^(file)(.*)(env\\$)'`

if [ -n "$row" ]; then
    echo "Syntax ENV is already installed"
    exit
fi

#Backup Syntax file
cp ${SYNTAX_FILE}{,.bak}

text_before='file \.\\\* unknown'
text_ins=`cat $SYNTAX_ADD_FILE`

line_num=`awk "/$text_before/{ print NR; exit }" $SYNTAX_FILE`
line_num_before=$((${line_num}-1))

txt1=`cat $SYNTAX_FILE | head -n ${line_num_before}`
txt2=`cat $SYNTAX_FILE | tail -n +${line_num_before}`

text="${txt1}"
text+=$(echo $'\n' && echo "${text_ins}")
text+=$(echo $'' && echo "${txt2}")

echo "$text" > $SYNTAX_FILE

echo "Installation completed."
