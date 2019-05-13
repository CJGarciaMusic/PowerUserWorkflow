function menuSelection($menu, $submenu)
    {
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate("Finale");
    $wshell.SendKeys("$menu$submenu")
    }
menuSelection %t e