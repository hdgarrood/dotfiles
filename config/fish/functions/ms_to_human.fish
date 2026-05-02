function ms_to_human
  if test $argv[1] -lt 1000
    echo -n "$argv[1]ms"
    return
  end
  set -l total_secs (math --scale 0 "$argv[1] / 1000")
  set -l tenths_of_sec (math --scale 0 "($argv[1] / 100) % 10")
  if test $total_secs -lt 60
    echo -n {$total_secs}.{$tenths_of_sec}s
    return
  end
  set -l total_mins (math --scale 0 "$total_secs / 60")
  set -l secs_of_min (math --scale 0 "$total_secs % 60")
  if test $total_mins -lt 60
    echo -n -s \
      $total_mins ':' \
      (printf "%02i" "$secs_of_min")
  else
    set -l total_hours (math --scale 0 "$total_mins / 60")
    set -l mins_of_hour (math --scale 0 "$total_mins % 60")
    echo -n -s \
      $total_hours ":" \
      (printf "%02i" "$mins_of_hour") ":" \
      (printf "%02i" "$secs_of_min")
  end
end
