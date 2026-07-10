CYAN=#005577
REDD=#770000
GRAY1=#222222
GRAY2=#444444
GRAY3=#bbbbbb
GRAY4=#eeeeee

set-option -g status-justify absolute-centre
set-option -g status-style bg=${GRAY1},fg=${GRAY3}               # whole background
set-option -g status-left-style bg=${CYAN},fg=${GRAY4}           # left
set-option -g status-right-style bg=${CYAN},fg=${GRAY4}          # right
set-option -g window-status-current-style bg=${CYAN},fg=${GRAY4} # center

set-option -g pane-border-style fg=${GRAY2}
set-option -g pane-active-border-style fg=${CYAN}
set-option -g pane-border-format "#{?pane_active,#[fg=${GRAY4}],#[fg=default]}[#{pane_index}: #{pane_current_command}]"
