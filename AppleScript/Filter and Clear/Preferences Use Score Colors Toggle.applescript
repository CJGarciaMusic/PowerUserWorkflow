on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, checkboxName)
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
					click menu item 3 of menu 1 of menu bar item "Finale" of menu bar 1
					repeat 8 times
						key code 125
					end repeat
					key code 126
					click checkbox checkboxName of window "Preferences - Display Colors"
					click UI element "Apply" of window "Preferences - Display Colors"
					click UI element "OK" of window "Preferences - Display Colors"
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
end chooseMenuItem

chooseMenuItem("Finale", "PreferencesÉ", "Use Score Colors")