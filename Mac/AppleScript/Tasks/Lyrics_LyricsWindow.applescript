on lyricWindowToggle(theMenuName, theMenuItemName, theSubMenuItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events" to tell process appName
			windows where title contains "Lyrics"
			if result is not {} then 
				perform action "AXRaise" of item 1 of result
				keystroke "w" using command down
			else
				click menu item theMenuItemName of menu theMenuName of menu bar 1
				click menu item theSubMenuItem of menu theMenuItemName of menu bar 1
			end if
		end tell
	on error
		set theAlertText to "A Stream Deck error has occurred."
		set theAlertMessage to theMenuItemName & " - " & theSubMenuItem & " wasn't able to be selected.\n\nPlease try again."
		display alert theAlertText message theAlertMessage as critical
	end try
end lyricWindowToggle

lyricWindowToggle("Tools", "Lyrics", "Lyrics Window…")