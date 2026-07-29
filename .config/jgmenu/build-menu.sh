#!/bin/sh
"$HOME/.config/jgmenu/wine-menu.sh" >"$HOME/.config/jgmenu/wine-menu.csv"
echo "^tag(wine_root)"
jgmenu_run apps | grep -v -i "wine"
tail -n +2 "$HOME/.config/jgmenu/wine-menu.csv"
