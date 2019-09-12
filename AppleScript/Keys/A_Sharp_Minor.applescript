on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, downInc, keyQuality)
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
				set activeMenuItem to enabled of menu item theMenuItemName of menu theMenuName of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
					key code 36
					set wait_time to 4
					set {i, 100} to {1, wait_time * 10}
					repeat until (window "Key Signature" exists) is not {} or (i ³ loop_count)
						set i to i + 1
						delay 0.1						
					end repeat
					repeat 14 times
						click UI element 1 of incrementor 1 of window "Key Signature"
					end repeat
					repeat downInc times
						click UI element 2 of incrementor 1 of window "Key Signature"
					end repeat
					click pop up button 1 of window "Key Signature"
					click menu item keyQuality of menu 1 of pop up button 1 of window "Key Signature"
					click button "OK" of window "Key Signature"
					return true
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage("Unable to change the key signature.\n\nPlease be sure your document is in focus and you have a region selected and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Key Signature", 0, "Minor Key")