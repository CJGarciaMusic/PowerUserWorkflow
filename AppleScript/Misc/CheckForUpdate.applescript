on theSplit(theString, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	set AppleScript's text item delimiters to oldDelimiters
	repeat with theItem in theArray
		if theItem contains "MAC STREAM DECK PROFILE VERSION " then
			set myNum to theItem
		end if
	end repeat
	return myNum
end theSplit

on removeMarkupFromText(theText)
	set tagDetected to false
	set theCleanText to ""
	repeat with a from 1 to length of theText
		set theCurrentCharacter to character a of theText
		if theCurrentCharacter is "<" then
			set tagDetected to true
		else if theCurrentCharacter is ">" then
			set tagDetected to false
		else if tagDetected is false then
			set theCleanText to theCleanText & theCurrentCharacter as string
		end if
	end repeat
	return theCleanText
end removeMarkupFromText

set theURL to "http://www.musicprep.com/jetstream/"
set theCurl to (do shell script "curl " & quoted form of theURL)
set myArray to theSplit(theCurl, "<")
set myText to removeMarkupFromText(myArray)

set myLength to (count of myText)
set firstNumber to (offset of "version" in myText)
set currentVersion to "190828"
set scribeVersion to (characters (firstNumber + 8) thru myLength of myText as text)

if currentVersion is equal to scribeVersion then
    tell application "System Events"
    	display dialog "You're up to date with the current " & currentVersion
    end tell
else
    tell application "System Events"
        set dialogText to "An update is available!"
        set dialogMessage to "You currently have " & currentVersion & "\n\nWould you like to update to version " & scribeVersion & "?"
        set myButton to button returned of (display dialog dialogMessage with title dialogText buttons {"No thank you", "Yes please!"} default button 2)
        if myButton is "No thank you" then
            return
        else
            do shell script "open " & theURL
        end if
    end tell
end if