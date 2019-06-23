on editFilter(theMenuName, theMenuItemName, filterItem1, filterItem2, filterItem3)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theMenuItemName of menu theMenuName of menu bar 1
				click button "None" of window "Clear Selected Items"
				click checkbox filterItem1 of window "Clear Selected Items"
				click checkbox filterItem2 of window "Clear Selected Items"
				click checkbox filterItem3 of window "Clear Selected Items"
	            click button "OK" of window "Clear Selected Items"
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to filterItem1 & " wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end editFilter

editFilter("Edit", "Clear Selected Items…", "Notes and Rests", "Markings", "Expressions: Tempo Marks, Tempo Alterations")