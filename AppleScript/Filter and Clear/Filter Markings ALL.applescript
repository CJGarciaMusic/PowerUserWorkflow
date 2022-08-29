on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on editFilter(theMenuName, theMenuItemName, filterItems)
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
			set activeMenuItem to enabled of menu item theMenuItemName of menu theMenuName of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
					click button "None" of window "Edit Filter"
					repeat with filterItem in filterItems
						click checkbox filterItem of window "Edit Filter"
					end repeat
					click button "OK" of window "Edit Filter"
					return true
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage(theMenuItemName & " wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end editFilter

editFilter("Edit", "Edit Filter…", {"Markings"})