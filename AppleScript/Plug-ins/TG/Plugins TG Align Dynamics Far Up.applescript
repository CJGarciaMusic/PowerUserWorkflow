on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(firstMenu, firstSubMenu, firstOption, secondMenu, secondSubMenu, secondOption, secondRadio)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell

	if appName does not contain "Finale" then
		errorMessage("Please make sure Finale is the front application")
		return false
	end if

	try
		tell application "System Events"
			tell process appName
				if menu item firstOption of menu of menu item firstSubMenu of menu firstMenu of menu bar 1 exists then
					key code 69 using {command down, option down}
				else
					click menu item secondOption of menu of menu item secondSubMenu of menu secondMenu of menu bar 1
					set myWindow to first window whose title contains "Align/Move Dynamics"
					click radio button secondRadio of myWindow
					click button "Go" of myWindow
					click button "Close" of myWindow
				end if
			end tell
		end tell
		return true
	on error
		errorMessage("The plug-in " & secondSubMenu & " wasn't able to be selected.\n\nPlease be sure your document is in focus try again.")
		return false
	end try
end subMenuItem

subMenuItem("TGTools", "Modify", "Align/Move...", "Plug-ins", "TG Tools", "Align/Move Dynamics...", "To Farthest Element")