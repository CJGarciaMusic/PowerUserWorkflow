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
            	set playback_check to value of attribute "AXMenuItemMarkChar" of menu item theMenuItemName of menu theMenuName of menu bar 1
				if playback_check is missing value then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
				end if
                set activeMenuItem to enabled of menu item "Minimize" of menu "Window" of menu bar 1
				repeat until activeMenuItem is true
                    click UI Element 4 of window "Playback Controls"
				end repeat
			end tell
		end tell
	on error
		errorMessage("Playback Controls couldn't be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end playbackControls

playbackControls("Window", "Playback Controls")