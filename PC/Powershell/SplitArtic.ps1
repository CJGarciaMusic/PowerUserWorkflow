function menuSelection($menubar, $menuitem, $submenuitem){
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate("Finale");
    $wshell.SendKeys("$menubar$menuitem$submenuitem")
    }
    menuSelection %i {jw lua} {split artic}