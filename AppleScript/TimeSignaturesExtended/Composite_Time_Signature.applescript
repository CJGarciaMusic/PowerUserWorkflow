on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, pushButton)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	
	if appName does not contain "Finale" then
		errorMessage("Finale is not in focus, please try again")
		return false
	end if
	
	try
		tell application "System Events"
			tell process appName
				set activeMenuItem to enabled of menu item theMenuItemName of menu theMenuName of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
					key code 36
					if not (window theMenuItemName exists) then
						error
					end if
				end if
			end tell
		end tell
		tell application "System Events"
			tell process appName
				ignoring application responses
					click button pushButton of window theMenuItemName
				end ignoring
			end tell
		end tell
		do shell script "killall System\\ Events"
		delay 0.1
	on error
		errorMessage("Unable to complete the time signature action.\n\nPlease be sure your document is in focus and you have a region selected and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Time Signature", "Composite...")