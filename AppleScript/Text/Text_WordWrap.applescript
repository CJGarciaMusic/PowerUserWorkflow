on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
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
				set getItem to enabled of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
				if getItem is true then
					click menu item theSubMenuItem of menu theMenuItemName of menu bar 1
                    return true
                else
                    error
                end if
			end tell
		end tell
	on error
		errorMessage(theMenuItemName & " - " & theSubMenuItem & " wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end subMenuItem

subMenuItem("Tools", "Text", "Word Wrap")