#!/bin/bash
export PROMPT_DIRTRIM=2

umask 0022;

. ~/.bashrcgit

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export DOCKER_BUILDKIT=1
export EDITOR=nano

fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
if [ -x kubectl ]; then
  source <(kubectl completion bash)
fi 
if [ -x helm ]; then
  source <(helm completion bash)
fi


#complete -F __start_kubectl knu
#complete -F __start_kubectl kns
#complete -F __start_kubectl knc


function lazygit() {
    git add . && git commit -a -m "$1" && git push
}

function lazyfix() {
  git add . && git commit -m "fuck" && git fix
}


eval "$(starship init bash)"

. ~/.bash_aliases

bind '"\C-H":backward-kill-word'
export PATH=$PATH:/usr/local/go/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
