#!/usr/bin/bash

# depends on "lnif" function (which depends on explicit $HOME paths); 
# cannot use environment variable until the bash files themselves are linked
source /z/750/dot/repos/shell-bash/config/workstation/generic/sourced_files/open/functions.bash

CURRENT_DIR=$(pwd)

#···············································································
#   SETUP SHARED FILES
#···············································································

BASH_SHARED_BASE='/z/750/dot/repos/shell-bash/config/workstation/generic/linked_files/configs/shared'

BASH_PROFILE="$BASH_SHARED_BASE/bash_profile.bash"
lnif "$BASH_PROFILE"    '/home/rigel/.bash_profile'
lnif "$BASH_PROFILE"    '/root/.bash_profile'

BASH_RC="$BASH_SHARED_BASE/bashrc.bash"
lnif "$BASH_RC"         '/home/rigel/.bashrc'
lnif "$BASH_RC"         '/root/.bashrc'

BASH_LOGOUT="$BASH_SHARED_BASE/bash_logout.bash"
lnif "$BASH_LOGOUT"     '/home/rigel/.bash_logout'
lnif "$BASH_LOGOUT"     '/root/.bash_logout'

#···············································································
#   SETUP SEPARATE HISTORY FILES
#···············································································

BASH_HISTORIES_BASE='/z/750/dot/repos/shell-bash/config/workstation/generic/linked_files/histories'

lnif "$BASH_HISTORIES_BASE/bash_history_user_normal.bash" \
'/home/rigel/.bash_history'

lnif "$BASH_HISTORIES_BASE/bash_history_user_super.bash" \
'/root/.bash_history'

#···············································································
cd $CURRENT_DIR
