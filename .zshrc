for file in ~/.{exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Mac -------------------------------------------------------------------------
if [[ $OS = mac ]]; then
	# iTerm
	if [[ $ITERM_SESSION_ID ]]; then
		export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND"
	fi

	[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"
fi
# End Mac ---------------------------------------------------------------------

# ZSH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

plugins=(
	git
	git-prompt
	zsh-autosuggestions
	python
	brew
	ssh-agent
	zsh-syntax-highlighting
  safe-paste
)

source $ZSH/oh-my-zsh.sh
[[ -e "/usr/local/share/zsh-completions" ]] && fpath=(/usr/local/share/zsh-completions $fpath)
fpath=( "$HOME/.zfunctions" $fpath )

# Light/Dark
if [[ $COLOR_MODE = light ]] ; then
	# ZSH Highlighting
	ZSH_HIGHLIGHT_STYLES[command]='fg=#005f00'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=#005f00'
	DIR_COLOR=022
else
	ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
	DIR_COLOR=226
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=251"
fi

# Spaceship
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true

autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_SUFFIX=""
SPACESHIP_GIT_BRANCH_PREFIX="%B%F{blue}("
SPACESHIP_GIT_BRANCH_SUFFIX="%B%F{blue})"
SPACESHIP_GIT_BRANCH_COLOR='blue'
SPACESHIP_GIT_STATUS_STASHED=''

SPACESHIP_DIR_COLOR=$DIR_COLOR
SPACESHIP_DIR_PREFIX="%B%F{$DIR_COLOR}[%f%b"
SPACESHIP_DIR_SUFFIX="%B%F{$DIR_COLOR}]%f%b\n"
if [[ $remote -eq 0 ]]; then
	SPACESHIP_DIR_SUFFIX="%B%F{$DIR_COLOR}]%f%b "
	SPACESHIP_PROMPT_ORDER=( ${SPACESHIP_PROMPT_ORDER[@]:0:2} host ${SPACESHIP_PROMPT_ORDER[@]:2} )
	SPACESHIP_HOST_SUFFIX="\n"
	SPACESHIP_HOST_COLOR_SSH=208
fi
SPACESHIP_DIR_TRUNC=0

SPACESHIP_EXEC_TIME_SUFFIX='\n'

SPACESHIP_CHAR_SYMBOL='λ'
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_CHAR_SYMBOL_ROOT='#'
SPACESHIP_PROMPT_ORDER=(
	exec_time
	git
	dir
	char
)
SPACESHIP_PROMPT_ADD_NEWLINE=false

# Z
[ -e "/usr/local/etc/profile.d/z.sh" ] && . /usr/local/etc/profile.d/z.sh
