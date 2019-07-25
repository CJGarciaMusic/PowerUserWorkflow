on editFilter(theMenuName, theMenuItemName, filterItems)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theMenuItemName of menu theMenuName of menu bar 1
				click button "None" of window "Clear Selected Items"
				repeat with filterItem in filterItems
					click checkbox filterItem of window "Edit Filter"
				end repeat
	            click button "OK" of window "Clear Selected Items"
			end tell
		end tell
		return true
	on error
		tell application "System Events"
			set theAlertText to "A Stream Deck error has occurred."
			set theAlertMessage to (filterItems as text) & " wasn't able to be selected.\n\nPlease try again."
			display alert theAlertText message theAlertMessage as critical
			return false
		end tell
	end try
end editFilter

editFilter("Edit", "Clear Selected Items…", {"Notes and Rests", "Markings", "Expressions: Tempo Marks, Tempo Alterations"})