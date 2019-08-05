on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "A Stream Deck error has occurred."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuItemName, theSubMenuItem, subToolName)
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
                keystroke "I"
                key code 123 using shift down
				click menu item subToolName of menu of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
                key code 124
			end tell
		end tell
		return true
	on error
		errorMessage("Adding an ellison wasn't able to execute.\n\nPlease make sure you are typing lyrics into your score and try again.")
		return false
	end try
end subMenuItem

subMenuItem("Text", "Font", "Engraver Font Set")