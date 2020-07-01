on theSplit(theString, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	set AppleScript's text item delimiters to oldDelimiters
	repeat with theItem in theArray
		if theItem contains "JetStream%20Mac%20proXL%20" then
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
	set theURL to "http://jetstreamfinale.com/twdmmfc0z1g345d7s5/"
	set theCurl to (do shell script "curl " & quoted form of theURL)
	set myArray to theSplit(theCurl, "<")
	set myText to removeMarkupFromText(myArray)
	set myLength to (count of myText)
	set firstNumber to (offset of "JetStream%20Mac%20proXL%20" in myText)
	set secondNumber to (characters (firstNumber + 26) thru myLength of myText as text)
	set scribeVersion to text 1 thru -23 of secondNumber
	set theDownload to text 9 thru -14 of myText
	
	if updateNumber is equal to scribeVersion then
		tell application "System Events"
			display dialog "You're up to date with the current version: " & updateNumber & "\n\nPlease check back again soon for a new version." with title "No Update Available" buttons {"OK"}
		end tell
	else if updateNumber > scribeVersion then
		tell application "System Events"
			set dialogText to "An odd thing has happened"
			set dialogMessage to "You seem to have a version that is newer than the one we are currently offering... How'd you do that?\n\nLet's get you back on the right track with the current build."
			display dialog dialogMessage with title dialogText buttons {"Sounds good, thank you!"}
			do shell script "open " & theDownload
		end tell
	else
		tell application "System Events"
			set dialogText to "An update is available!"
			set dialogMessage to "You currently have " & updateNumber & "\n\nWould you like to update to version " & scribeVersion & "?"
			set myButton to button returned of (display dialog dialogMessage with title dialogText buttons {"No thank you", "Yes please!"} default button 2)
			if myButton is "No thank you" then
				return
			else
				do shell script "open " & theDownload
			end if
		end tell
	end if
end getUpdate

getUpdate("200630")