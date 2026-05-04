function jj-snapshot --on-event fish_prompt --desc "run a jj snapshot so that prompt info is up-to-date"
  jj log -r 'none()'
end
