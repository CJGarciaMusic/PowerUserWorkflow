on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on exportGraphicPartsAndScore(file_type)	
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
				keystroke " - Score"
				click UI element "Save" of window "Save PDF File"
				if sheet 1 of window "Save PDF File" exists then
					click UI element "Replace" of sheet 1 of window "Save PDF File"
				end if
				key code 47 using {option down, command down}
				set partList to name of every menu item of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1
				if partList contains "Generate Parts" then
					error
					return false
				end if
				set myCount to (count of partList) - 4
				repeat with partNum from 1 to myCount
					click menu item 2 of menu 1 of menu bar item "Graphics" of menu bar 1
					click pop up button 1 of window "Export Pages"
					click menu item file_type of menu 1 of pop up button 1 of window "Export Pages"
					click radio button "All" of window "Export Pages"
					click UI element "OK" of window "Export Pages"
					key code 124
					keystroke " - "
					keystroke (partNum as text) & " "
					keystroke ((item partNum of partList) as text)
					click UI element "Save" of window "Save PDF File"
					if sheet 1 of window "Save PDF File" exists then
						click UI element "Replace" of sheet 1 of window "Save PDF File"
					end if
					key code 47 using {option down, command down}
				end repeat
			end tell
		end tell
		return true
	on error
		errorMessage("You don't appear to have any parts generated. Please Generate Parts and try again.")
		return false
	end try
end exportGraphicPartsAndScore

exportGraphicPartsAndScore("PDF")