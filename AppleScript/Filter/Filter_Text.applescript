on editFilter(theMenuName, theMenuItemName, filterItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theMenuItemName of menu theMenuName of menu bar 1
				click button "None" of window "Edit Filter"
				click checkbox filterItem of window "Edit Filter"
	            click button "OK" of window "Edit Filter"
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to filterItem & " wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end editFilter

editFilter("Edit", "Edit Filter…", "Text")