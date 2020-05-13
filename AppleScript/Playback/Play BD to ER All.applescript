on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on playbackControls(theMenuName, theMenuItemName, jetpackCode)
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
				if UI element 8 of window theMenuItemName exists then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
				end if
				click menu item "JetStream Finale Controller" of menu of menu item "JW Lua" of menu "Plug-ins" of menu bar 1
				keystroke jetpackCode
				click button "OK" of window "JetStream Finale Controller"
				click menu item theMenuItemName of menu theMenuName of menu bar 1
				click UI element 2 of window theMenuItemName
				click UI element 8 of window theMenuItemName
				set activeMenuItem to enabled of menu item "Minimize" of menu "Window" of menu bar 1
				repeat until activeMenuItem is true
				end repeat
				click menu item theMenuItemName of menu theMenuName of menu bar 1
			end tell
		end tell
	on error
		errorMessage("Playback Controls couldn't be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end playbackControls

playbackControls("Window", "Playback Controls", "8002")