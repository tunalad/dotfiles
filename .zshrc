#
# ~/.zshrc
#

PS4='+%D{%s.%6.} %N:%i> '
exec 3>&2 2>/tmp/zshrc_trace.log
setopt xtrace

. ~/.shellrc

unsetopt xtrace
exec 2>&3 3>&-
