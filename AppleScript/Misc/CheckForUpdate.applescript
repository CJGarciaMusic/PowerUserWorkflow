on theSplit(theString, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	set AppleScript's text item delimiters to oldDelimiters
	repeat with theItem in theArray
		if theItem contains "MAC JETSTREAM PROFILE " then
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

on getUpdate(updateNumber)
	set theURL to "http://jetstreamfinale.com/download/"
	set theCurl to (do shell script "curl " & quoted form of theURL)
	set myArray to theSplit(theCurl, "<")
	set myText to removeMarkupFromText(myArray)

	set myLength to (count of myText)
	set firstNumber to (offset of "PROFILE" in myText)
	set scribeVersion to (characters (firstNumber + 8) thru myLength of myText as text)

	if updateNumber is equal to scribeVersion then
		tell application "System Events"
			display dialog "You're up to date with the current " & updateNumber
		end tell
	else
		tell application "System Events"
			set dialogText to "An update is available!"
			set dialogMessage to "You currently have " & updateNumber & "\n\nWould you like to update to version " & scribeVersion & "?"
			set myButton to button returned of (display dialog dialogMessage with title dialogText buttons {"No thank you", "Yes please!"} default button 2)
			if myButton is "No thank you" then
				return
			else
				do shell script "open " & theURL
			end if
		end tell
	end if
end getUpdate

getUpdate("190904")