on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(firstMenu, firstSubMenu, firstOption, secondMenu, secondSubMenu, secondOption)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell

	if appName does not contain "Finale" then
		errorMessage("Finale is not in focus, please try again")
		return false
	end if

	try
		tell application "System Events"
			tell process appName
				if menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1 exists then
					click menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1
					key code 36
					key code 53
				else
					click menu item secondOption of menu of menu item secondSubMenu of menu secondMenu of menu bar 1
					click button "Go" of window "Easy Tremolos" 
					click button "Close" of window "Easy Tremolos"
				end if
			end tell
		end tell
		return true
	on error
		errorMessage("The plug-in " & secondSubMenu & " wasn't able to be selected.\n\nPlease be sure your document is in focus try again.")
		return false
	end try
end subMenuItem

subMenuItem("TGTools", "Music", "Tremolos...", "Plug-ins", "TG Tools", "Easy Tremolos...")