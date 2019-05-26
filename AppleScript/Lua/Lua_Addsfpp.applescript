on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem, windowName, listItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
                tell table 1 of scroll area 1 of window windowName
                    select (row 1 where value of text field 1 is listItem)
                end tell
                click button "OK" of window windowName
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to listItem & "  wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end subMenuItem

subMenuItem("Plug-ins", "JW Lua", "Stream Deck", "Stream Deck for Finale", "Add sfzp")