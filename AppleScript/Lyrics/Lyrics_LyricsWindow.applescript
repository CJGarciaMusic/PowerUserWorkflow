on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on lyricWindowToggle(theMenuName, theMenuItemName, theSubMenuItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell

	if appName does not contain "Finale" then
		errorMessage("Finale is not in focus, please try again")
		return false
	end if

	try
		tell application "System Events" to tell process appName
			windows where title contains "Lyrics"
			if result is not {} then 
				perform action "AXRaise" of item 1 of result
				keystroke "w" using command down
				return true
			else
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
			end if
		end tell
	on error
		errorMessage(theMenuItemName & " - " & theSubMenuItem & " wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end lyricWindowToggle

lyricWindowToggle("Tools", "Lyrics", "Lyrics Window…")