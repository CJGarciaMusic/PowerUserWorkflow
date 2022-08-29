on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
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
					set getItem to enabled of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
					if getItem is true then
						click menu item theSubMenuItem of menu theMenuItemName of menu bar 1
						return true
					else
						error
					end if
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage("This " & theMenuItemName & " tool operation wasn't able to be performed.\n\nPlease be sure you have made a selection and try again.")		
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Staff", "Show Empty Staves")