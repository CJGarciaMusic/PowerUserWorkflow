on chooseMenuItem(theMenuName, theMenuItemName)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				tell menu bar 1
					tell menu bar item theMenuName
						tell menu theMenuName
							click menu item theMenuItemName
						end tell
					end tell
				end tell
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to "The " & theMenuItemName & " tool wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Articulation")