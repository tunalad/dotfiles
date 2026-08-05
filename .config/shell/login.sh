if [ "$DISTRO" = "void" ] && [ -z "$_RUNSVDIR_STARTED" ]; then
    export _RUNSVDIR_STARTED=1
    runsvdir ~/.config/service &
fi
