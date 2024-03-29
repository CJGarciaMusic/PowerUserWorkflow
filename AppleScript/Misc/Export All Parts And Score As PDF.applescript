on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on exportDocument(myApp, file_type, file_name, filePath)
	tell application "System Events"
		tell process myApp
			click menu item "Graphics" of menu "Tools" of menu bar 1
			click menu item 2 of menu 1 of menu bar item "Graphics" of menu bar 1
			click pop up button 1 of window "Export Pages"
			click menu item file_type of menu 1 of pop up button 1 of window "Export Pages"
			click radio button "All" of window "Export Pages"
			click UI element "OK" of window "Export Pages"
			repeat until window "Save PDF File" exists
			end repeat
			if filePath is not false then
				keystroke "g" using {shift down, command down}
				keystroke filePath
				click UI element "Go" of sheet 1 of window "Save PDF File"
			end if
			key code 124
			keystroke " - " & file_name as text
			click UI element "Save" of window "Save PDF File"
			if sheet 1 of window "Save PDF File" exists then
				click UI element "Replace" of sheet 1 of window "Save PDF File"
			end if
		end tell
	end tell
end exportDocument

on exportGraphicPartsAndScore(file_type, finaleApp, filePath)
	
	tell application finaleApp
		activate
	end tell
	
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
				set instList to (name of every menu item of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1)
				if (item 1 of instList) is "Generate Parts" then
					my errorMessage("You don't appear to have any parts generated. Please Generate Parts and try again.")
					return false
				else
					if (menu item (item 1 of instList) of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1) exists then
						click menu item (item 1 of instList) of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1
						set instName to (item 1 of instList)
						my exportDocument(appName, file_type, instName, filePath)
					end if
					repeat with aNumber from 2 to ((length of instList) - 4)
						if (menu item (item aNumber of instList) of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1) exists then
							click menu item (item aNumber of instList) of menu 1 of menu item "Edit Part" of menu 1 of menu bar item "Document" of menu bar 1
							set instName to (item aNumber of instList)
							my exportDocument(appName, file_type, instName, false)
						end if
					end repeat
					click menu item "Edit Score" of menu 1 of menu bar item "Document" of menu bar 1
					my exportDocument(appName, file_type, "Score", false)
				end if
			end tell
		end tell
		return true
	on error
		errorMessage("Something went wrong with exporting to PDF. Please try agian.")
		return false
	end try
end exportGraphicPartsAndScore

tell application "System Events"
	set myFinale to name of the first process whose frontmost is true
	try
		set theOutputFolder to choose folder with prompt "Please select a destination for your PDFs:"
		set thisPOSIXPath to (the POSIX path of theOutputFolder)
		my exportGraphicPartsAndScore("PDF", myFinale, thisPOSIXPath)
	on error
		return false
	end try
end tell