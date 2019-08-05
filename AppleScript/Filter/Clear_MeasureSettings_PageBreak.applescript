on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "A Stream Deck error has occurred."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on editClear(theMenuName, theMenuItemName, filterItems)
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
				set activeMenuItem to enabled of menu item theMenuItemName of menu theMenuName of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
					click button "None" of window "Clear Selected Items"
					repeat with filterItem in filterItems
						click checkbox filterItem of window "Clear Selected Items"
					end repeat
					click button "OK" of window "Clear Selected Items"
					return true
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage(theMenuItemName & " wasn't able to be selected.\n\nPlease select a region and try again.")
		return false
	end try
end editClear

editClear("Edit", "Clear Selected Items…", {"Page Breaks"})