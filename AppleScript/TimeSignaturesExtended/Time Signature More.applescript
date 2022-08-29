on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, pushButton)
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
                    if not (window theMenuItemName exists) then
						error
					end if
                    repeat until (button "Fewer Options" of window theMenuItemName exists)
                        click button pushButton of window theMenuItemName
                    end repeat
                    set moreOptionsInUse to 0
                    if value of (checkbox "Use a Different Time Signature for Display" of window theMenuItemName) = 1 then
                        set moreOptionsInUse to 1
                    end if
                    if moreOptionsInUse is 0 then
                        click checkbox "Use a Different Time Signature for Display" of window theMenuItemName
                    end if
                end if
			end tell
		end tell
	on error
		errorMessage("Unable to complete the time signature action.\n\nPlease be sure your document is in focus and you have a region selected and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Time Signature", "More Options")