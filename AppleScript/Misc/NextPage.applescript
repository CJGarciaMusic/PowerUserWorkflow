on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on pagePush(uiButton)
	tell application "System Events"
		key code 48 using command down
		set appName to name of the first process whose frontmost is true
	end tell
	
	if appName does not contain "Finale" then
		errorMessage("Please make sure Finale is the front application")
		return false
	end if
	
	try
		tell application "System Events"
			tell process appName
				set frontWindow to 0
				set myList to properties of windows
				repeat with aNumber from 1 to (length of myList)
					set theProp to item aNumber of myList
					set findItem to theProp's strings as text
					if findItem contains "AXStandardWindow" then
						set frontWindow to aNumber
						exit repeat
					end if
				end repeat
				click UI element uiButton of window frontWindow
				return true
			end tell
		end tell
	on error
		errorMessage("Could not press \"Next Page\".\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end pagePush

pagePush(7)
