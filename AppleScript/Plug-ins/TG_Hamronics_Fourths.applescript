on subMenuItem(firstMenu, firstSubMenu, firstOption, secondMenu, secondSubMenu, secondOption)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				if menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1 exists then
					click menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1
					key code 36
					key code 53
				else
					click menu item secondOption of menu of menu item secondSubMenu of menu secondMenu of menu bar 1
					click radio button "Fourths" of window "Easy Harmonics"
                    click button "Apply" of window "Easy Harmonics"
					key code 53
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

subMenuItem("TGTools", "Music", "Harmonics...", "Plug-ins", "TG Tools", "Easy Harmonics...")