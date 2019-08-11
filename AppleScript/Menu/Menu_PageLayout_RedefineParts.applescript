on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "A Stream Deck error has occurred."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem, subToolName, popUpSelection)
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
					set getItem to enabled of menu item subToolName of menu of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
					if item 1 of getItem is true then
						click menu item subToolName of menu of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
						repeat until window "Redefine Selected Pages" exists
						end repeat
						click pop up button 1 of window "Redefine Selected Pages"
						click menu item popUpSelection of menu 1 of pop up button 1 of window "Redefine Selected Pages"
						click UI element "OK" of window "Redefine Selected Pages"
						repeat until window "Redefine Pages" exists
						end repeat
						click UI element "OK" of window "Redefine Pages"
						return true
					else
						error
					end if
				else
					error
				end if
			end tell
		end tell
		return true
	on error
		errorMessage(theMenuItemName & " - " & theSubMenuItem & " wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end subMenuItem

subMenuItem("Tools", "Page Layout", "Redefine Pages", "Selected Pages of Selected Parts/Score…", "All Parts")