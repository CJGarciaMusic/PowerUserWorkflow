on subMenuItem(theMenuItemName, theSubMenuItem, subToolName)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
                -- key code 123 using shift down
                -- keystroke "c" using command down
                -- key code 124
                keystroke "I"
                key code 123 using shift down
				click menu item subToolName of menu of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
                key code 124
                -- keystroke "v" using command down
			end tell
		end tell
		return true
	on error
		set theAlertText to "A Stream Deck error has occurred."
        set theAlertMessage to theMenuItemName & " - " & theSubMenuItem & " - " & subToolName & " wasn't able to be selected.\n\nPlease try again."
        display alert theAlertText message theAlertMessage as critical
		return false
	end try
end subMenuItem

subMenuItem("Text", "Font", "Engraver Font Set")

-- tell application "System Events"
--     tell process "Finale"
--         -- set xxx to name of every menu item of menu of menu item "Font" of menu "Text" of menu bar 1
--             set yyy to value of attribute "AXMenuItemMarkChar" of every menu item of menu of menu item "Font" of menu "Text" of menu bar 1     
--     end tell
-- end tell
