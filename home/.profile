# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# include dirs in PATH
dirs=("$HOME/.bin" `ruby -rubygems -e "puts Gem.user_dir"`)
for dir in "${dirs[@]}"
do
    if [ -d $dir ] ; then
        PATH="$PATH:$dir"
    fi
done
unset dir
unset dirs

# set any environment vars
export EDITOR=vim
