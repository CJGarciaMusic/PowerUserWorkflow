on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem, topBottom, singleNote, lineNumber)
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
				set activeMenuItem to enabled of menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
				if item 1 of activeMenuItem is true then
					click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
					set myList to title of every window
					if topBottom is "Bottom" then
						click checkbox "  Counted from bottom:" of tab group 1 of (first window whose name contains "Process Extracted Parts")
					end if
					if singleNote is false then
						click checkbox "  Keep single notes:" of tab group 1 of (first window whose name contains "Process Extracted Parts")
					end if
					if lineNumber is not 1 then
						keystroke lineNumber
					end if
					click UI element "Go" of (first window whose name contains "Process Extracted Parts")

					if UI element "No" of window 1 exists then
						click UI element "Yes" of window 1
					end if
					click UI element "Close" of (first window whose name contains "Process Extracted Parts")
					return true
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage("The " & theSubMenuItem & " plug-in wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end subMenuItem

subMenuItem("Plug-ins", "TG Tools", "Process Extracted Parts...", "Top", true, 1)