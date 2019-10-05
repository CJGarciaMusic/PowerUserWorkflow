on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "A Stream Deck error has occurred."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on exportGraphicCurrentPart(file_type)
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
				click menu item "Graphics" of menu "Tools" of menu bar 1
				click menu item "Edit Score" of menu "Document" of menu bar 1
				click menu item 2 of menu 1 of menu bar item "Graphics" of menu bar 1
				click pop up button 1 of window "Export Pages"
				click menu item file_type of menu 1 of pop up button 1 of window "Export Pages"
				click radio button "All" of window "Export Pages"
				click UI element "OK" of window "Export Pages"
				key code 124
				click UI element "Save" of window "Save PDF File"
				if sheet 1 of window "Save PDF File" exists then
					click UI element "Replace" of sheet 1 of window "Save PDF File"
				end if
			end tell
		end tell
		return true
	on error
		errorMessage("Couldn't select export to PDF.")
		return false
	end try
end exportGraphicCurrentPart

exportGraphicCurrentPart("PDF")