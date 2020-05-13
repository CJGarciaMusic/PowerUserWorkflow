on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, direction, chromOrDia, transposeSelect)
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
					click radio button direction of radio group 1 of window "Transposition"
                    click radio button chromOrDia of radio group 2 of window "Transposition"
                    click pop up button 1 of window "Transposition" 
                    click menu item transposeSelect of menu 1 of pop up button 1 of window "Transposition"
					click button "OK" of window "Transposition"
					return true 
				else
					error 
				end if
			end tell
		end tell
	on error
		errorMessage(theMenuItemName & " wasn't able to be selected.\n\nPlease be sure the region you selected is using a Standard Notation Style and that Finale is in focus and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Utilities", "Transpose…", "Up", "Chromatically", "Augmented Sixth")