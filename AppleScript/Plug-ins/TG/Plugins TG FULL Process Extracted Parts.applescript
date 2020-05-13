on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
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
				click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
			end tell
		end tell
		return true
	on error
		errorMessage("The plug-in " & secondSubMenu & " wasn't able to be selected.\n\nPlease be sure your document is in focus try again.")
		return false
	end try
end subMenuItem

subMenuItem("TGTools", "Parts", "Process extracted parts...")