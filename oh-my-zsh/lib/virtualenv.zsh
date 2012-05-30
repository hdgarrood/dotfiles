## VIRTUALENV
VIRTUAL_ENV_DISABLE_PROMPT="true"
WORKON_HOME=$HOME/.virtualenv
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
