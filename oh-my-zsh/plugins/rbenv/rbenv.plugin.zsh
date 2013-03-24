FOUND_RBENV=0
for rbenvdir in "$HOME/.rbenv" "/usr/local/rbenv" "/opt/rbenv" ; do
  if [ -d $rbenvdir/bin -a $FOUND_RBENV -eq 0 ] ; then
    FOUND_RBENV=1
    export RBENV_ROOT=$rbenvdir
    export PATH=${rbenvdir}/bin:$PATH
    eval "$(rbenv init -)"

    function rbenv_prompt_info() {
      if [[ -n $(current_gemset) ]] ; then
        echo "$(current_ruby)@$(current_gemset)"
      else
        echo "$(current_ruby)"
      fi
    }
  fi
done
unset rbenvdir

if [ $FOUND_RBENV -eq 0 ] ; then
  function rbenv_prompt_info() { echo "system: $(ruby -v | cut -f-2 -d ' ')" }
fi
