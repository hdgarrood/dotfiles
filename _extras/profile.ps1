function to-array {
  begin { $output = @(); }
  process { $output += $_; }
  end { return ,$output; }
}

function which($cmd) {
    get-command $cmd | select path
}

# posh-git stuff
import-module posh-git 2>&1 | out-null
if ($?) {
    function prompt {
        $tmp_exit_code = $LASTEXITCODE
        $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
        write-host "PS: " -nonewline
        write-host (get-location) -nonewline
        write-vcsstatus
        write-host "`n" -nonewline
        $global:LASTEXITCODE = $tmp_exit_code
        return "> "
    }

    enable-gitcolors
}
