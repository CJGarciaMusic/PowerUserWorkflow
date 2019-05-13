on subMenuItem(theAppName, theMenuName, theMenuItemName, theSubMenuItem)
	try
		tell application theAppName
			activate
		end tell
		tell application "System Events"
			tell process theAppName
				click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
			end tell
		end tell
		return true
	on error
		set theAlertText to "An error has occurred."
        set theAlertMessage to "This item may not be selectable. Please try again.\n\nIf you continue experiencing issues,\nplease reach out to CJGarciaMusic@gmail.com"
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end subMenuItem

subMenuItem("Finale", "Tools", "Simple Entry Rest", "Eighth rest")