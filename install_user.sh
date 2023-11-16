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
SYNTAX_PATH_GLOBAL="/usr/share/mc/syntax"
SYNTAX_FILE_GLOBAL="${SYNTAX_PATH_GLOBAL}/${SYNTAX_FILE_NAME}"

SYNTAX_PATH="${HOME}/.config/mc/mcedit"
SYNTAX_FILE="${SYNTAX_PATH}/${SYNTAX_FILE_NAME}"

SYNTAX_MY_PATH="${SCRIPT_PATH}/syntax"
SYNTAX_ADD_FILE="$SYNTAX_MY_PATH/${SYNTAX_FILE_NAME}"
SYNTAX_EXT_FILE_NAME="env.syntax"
SYNTAX_EXT_FILE="$SYNTAX_PATH/$SYNTAX_EXT_FILE_NAME"

# Copy files *.syntax to user config
mkdir -p $SYNTAX_PATH
cp ${SYNTAX_MY_PATH}/*.syntax ${SYNTAX_PATH}

if [ -f "$SYNTAX_FILE" ]; then
    row=`cat "$SYNTAX_FILE" | grep -E '^(file)(.*)(env\\$)'`

    if [ -n "$row" ]; then
        echo "Syntax ENV is already installed"
        exit
    fi

    #Backup Syntax file
    cp ${SYNTAX_FILE}{,.bak}
else
    cp ${SYNTAX_FILE_GLOBAL} ${SYNTAX_FILE}
    chmod 644 ${SYNTAX_FILE}
fi

text_before='file \.\\\* unknown'
text_ins=`cat $SYNTAX_ADD_FILE | sed "s|${SYNTAX_EXT_FILE_NAME}|${SYNTAX_EXT_FILE}|"`

line_num=`awk "/$text_before/{ print NR; exit }" $SYNTAX_FILE`
line_num_before=$((${line_num}-1))

txt1=`cat $SYNTAX_FILE | head -n ${line_num_before}`
txt2=`cat $SYNTAX_FILE | tail -n +${line_num_before}`

text="${txt1}"
text+=$(echo $'\n' && echo "${text_ins}")
text+=$(echo $'' && echo "${txt2}")

echo "$text" > $SYNTAX_FILE

echo "Installation completed."
