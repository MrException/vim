# specify my colors for zsh
local color_brown=$'\e[01;032m'
local color_blue=$'\e[01;034m'

local user="%{$color_brown%}%n@%m%{$reset_color%}"
local pwd="%{$color_blue%}%~%{$reset_color%}"
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'

PROMPT="${user}:${pwd}$ "
RPROMPT="${return_code}"
