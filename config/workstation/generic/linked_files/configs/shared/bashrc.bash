# DEFAULTS FROM ARCH:
#···············································································

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#···············································································
#   IMPORTS
#···············································································

SOURCED_BASE='/z/750/dot/repos/shell-bash/config/workstation/generic/sourced_files'

#   ALIASES OPEN
ALIASES_OPEN_FILE="$SOURCED_BASE/open/aliases.bash"
if [ -f "$ALIASES_OPEN_FILE" ]; then
    source "$ALIASES_OPEN_FILE"
fi

#   EXPORTED OPEN ENVIRONMENT VARIABLES
EXPORTS_OPEN_FILE="$SOURCED_BASE/open/exports.bash"
if [ -f "$EXPORTS_OPEN_FILE" ]; then
    source "$EXPORTS_OPEN_FILE"
fi
