#!/usr/bin/bash
#
#   check with http://www.shellcheck.net
#   prefer explicitness over cleverness, generally; e.g., use "source" not "."
#   include this file in scripts that need it, via URI or environment variable
#
#···············································································

# SHARED VARIABLES

TIMESTAMP_UNIX=$(date +"%s")

TEXT_RED='\033[0;31m'
TEXT_YEL='\033[0;33m'
TEXT_NC='\033[0m' # No Color

#···············································································

function divyel () {
    DIVIDER_80_YEL="${TEXT_YEL}################################################################################${TEXT_NC}"
    echo -e "$DIVIDER_80_YEL"
}

#···············································································

function lnif () {
    # explicit paths are the only way the lnif function knows whether to use sudo
    # (e.g., omit $HOME variable from target path in scripts tha call this function)
    # consider testing the SOURCE files also
    
    MSG_DIR="Existing directory, making backup before linking"
    MSG_FILE="Existing file, making backup before linking"
    MSG_LINK="Link $2 exists, doing nothing"
    MSG_BARE="Nothing found, creating link ..."
    MSG_WARN="    ${TEXT_RED}(If a symlink is not found initially on a second pass, but
    subsequently creating it fails after testing for its presence,
    then go manually inspect what was created on the first pass.)${TEXT_NC}"

    # check if symlink target is in directories only root can write to:
    if [[ "$2" == *"/etc/"* || "$2" == *"/root/"* ]]; then
    ####################################################
        if sudo test -d "$2" && sudo test ! -L "$2" ; then
            echo "$MSG_DIR"
            sudo mv -v "$2" "$2_bak_$TIMESTAMP_UNIX"
            sudo ln -vs "$1" "$2"
            echo
        elif sudo test -f "$2" && sudo test ! -L "$2" ; then
            echo "$MSG_FILE"
            sudo mv -v "$2" "$2_bak_$TIMESTAMP_UNIX"
            sudo ln -vs "$1" "$2"
            echo
        elif sudo test -e "$2" && sudo test -L "$2" ; then
            echo "$MSG_LINK"
            echo
        else
            echo "$MSG_BARE"
            echo -e "$MSG_WARN"
            sudo ln -vs "$1" "$2"
            echo
        fi # FILE TYPE TESTING AND ACTIONS
    ####################################################
    else    #   NO SUDO NEEDED
    ####################################################
        if [[ -d "$2" && ! -L "$2" ]]; then
            echo "$MSG_DIR"
            mv -v "$2" "$2_bak_$TIMESTAMP_UNIX"
            ln -vs "$1" "$2"
            echo
        elif [[ -f "$2" && ! -L "$2" ]]; then
            echo "$MSG_FILE"
            mv -v "$2" "$2_bak_$TIMESTAMP_UNIX"
            ln -vs "$1" "$2"
            echo
        elif [[ -e "$2" && -L "$2" ]]; then
            echo "$MSG_LINK"
            echo
        else
            echo "$MSG_BARE"
            echo -e "$MSG_WARN"
            ln -vs "$1" "$2"
            echo
        fi # FILE TYPE TESTING AND ACTIONS
    ####################################################
    fi # SUDO TESTING
}

#···············································································

function mdif () {
    # if you have to mkdir, you need to re-evaluate;
    # always prefer linking over mkdir in most cases

    EXISTS="Directory $1 exists"

    if [[ "$1" == *"/root/"* || "$1" == *"/etc/"* ]]; then
        if [ -d "$1" ]; then
            echo "$EXISTS"
        else
            sudo mkdir -v "$1"
        fi
    else # NO SUDO
        if [ -d "$1" ]; then
            echo "$EXISTS"
        else
            mkdir -v "$1"
        fi
    fi
}

#···············································································
