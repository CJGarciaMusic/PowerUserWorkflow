on subMenuItem(firstMenu, firstSubMenu, firstOption, secondMenu, secondSubMenu, secondOption, secondRadio)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				if menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1 exists then
					key code 69 using {command down, option down}
				else
					click menu item secondOption of menu of menu item secondSubMenu of menu secondMenu of menu bar 1
					click radio button secondRadio of window "Align/Move Dynamics"
					click button "Go" of window "Align/Move Dynamics"
					click button "Close" of window "Align/Move Dynamics"
				end if
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to "The plug-in " & secondSubMenu & " wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end subMenuItem

subMenuItem("TGTools", "Modify", "Align/Move...", "Plug-ins", "TG Tools", "Align/Move Dynamics...", "To Farthest Element")