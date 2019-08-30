on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName, pushButton, compositeTop, compositeBottom)
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
				set activeMenuItem to enabled of menu item theMenuItemName of menu "Tools" of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu "Tools" of menu bar 1
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
					click button "Composite..." of window theMenuItemName
				end ignoring
			end tell
		end tell
		
		do shell script "killall System\\ Events"
		delay 0.1
		tell application "System Events"
			tell process appName
				repeat until (window "Composite Time Signature" exists) 
				end repeat
				set compositeInUse to 0
				if value of (checkbox "Use EDUs for Beat Duration" of window "Composite Time Signature") = 1 then
					set compositeInUse to 1
				end if
				if compositeInUse is 0 then
					click checkbox "Use EDUs for Beat Duration" of window "Composite Time Signature"
					set topCount to (count of compositeTop)
					set bottomCount to (count of compositeBottom)
					if topCount = bottomCount then
						repeat with comptime from 1 to topCount
							keystroke item comptime of compositeTop
							key code 48
							keystroke item comptime of compositeBottom
							key code 48
						end repeat
					end if
					click button "OK" of window "Composite Time Signature"
					click button "More Options" of window theMenuItemName
					click checkbox "Use a Different Time Signature for Display" of window theMenuItemName
					key code 48
					keystroke "7"
					click pop up button 1 of window theMenuItemName
					click menu item "Eighth Note" of menu 1 of pop up button 1 of window theMenuItemName
					click button "OK" of window theMenuItemName
				end if
			end tell
		end tell
	on error
		errorMessage("Unable to change the time signature.\n\nPlease be sure your document is in focus and you have a region selected and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Tools", "Time Signature", "Composite...", {1, 1, 1}, {1024, 1024, 1536})