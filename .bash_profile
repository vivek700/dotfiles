#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "/home/vivek/.deno/env"
source /home/vivek/.local/share/bash-completion/completions/deno.bash
. "$HOME/.cargo/env"


if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then 
  exec start-hyprland &> ~/hypr_logs.txt
else 
  echo "Hyprland skip: WAYLAND_DISPLAY=$WAYLAND_DISPLAY, VTNR=$XDG_VTNR"
fi
