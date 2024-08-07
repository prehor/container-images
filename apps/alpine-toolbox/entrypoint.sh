#!/bin/bash

# Setup Git global config
if [[ "${GITCONFIG}" =~ '^(1|on|yes|true)$' ]]; then
    if [ ! -e ~/.gitconfig ]; then
        cat > ~/.gitconfig <<EOF
[filter "lfs"]
        process = git-lfs filter-process
        required = true
        clean = git-lfs clean -- %f
        smudge = git-lfs smudge -- %f
[branch]
        autosetuprebase = always
[safe]
        directory = /config
[user]
EOF
        if [ -n "${GITCONFIG_USER_MAIL}" ]; then
            echo "        email = ${GITCONFIG_USER_MAIL}" >> ~/.gitconfig
        fi
        if [ -n "${GITCONFIG_USER_NAME}" ]; then
            echo "        name = ${GITCONFIG_USER_NAME}" >> ~/.gitconfig
        fi
    fi
fi

# Uses default command if no command is given or the first argument is an option
if [[ ${#@} -eq 0 || ${1:0:1} == '-' ]]; then
    set -- "/bin/bash" "$@"
fi

# Execute command
exec "$@"
