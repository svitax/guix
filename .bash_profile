# Set up Guix Home profile
if [ -f ~/.profile ]; then . ~/profile; fi

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Prepend setuid programs.
export PATH=/run/setuid-programs:$PATH
