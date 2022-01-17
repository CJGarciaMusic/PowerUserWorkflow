#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Version: 210304
 Script Function: JetStream Finale Controller for Windows
#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <GuiMenu.au3>
#include <GuiListView.au3>
#include <String.au3>
#include <INet.au3>
#include <StringConstants.au3>

Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

Func MsgError($text)
    MsgBox($MB_OK, "JetStream Alert", $text)
EndFunc

Func LuaMenu($luaNum)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "RPG Lua", "JetStream Finale Controller") Then
	  WinWaitActive("JetStream")
	  If WinGetTitle("JetStream Finale Controller") Then
		 Send($luaNum)
		 Send("{Enter}")
	  EndIf
   Else
	  SetError(1)
   EndIf
EndFunc

Func MenuItem($MenuName, $MenuItemName)
   If WinMenuSelectItem("[CLASS:Finale]", "", $MenuName, $MenuItemName) Then
   Else
	  SetError(1)
   EndIf
EndFunc

Func SubmenuItem($MenuName, $MenuItemName, $SubMenuItemName)
   If WinMenuSelectItem("[CLASS:Finale]", "", $MenuName, $MenuItemName, $SubMenuItemName) Then
   Else
	  SetError(1)
   EndIf
EndFunc

Func SubsubmenuItem($MenuName, $MenuItemName, $SubMenuName, $SubMenuItemName)
   If WinMenuSelectItem("[CLASS:Finale]", "", $MenuName, $MenuItemName, $SubMenuName, $SubMenuItemName) Then
   Else
	  SetError(1)
   EndIf
EndFunc

Func FilterItems($actionType, $filterItems)
   If $actionType = "Filter" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Edit Filter...")
   ElseIf $actionType = "Clear" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Cl&ear Selected Items...")
   Else
	  SetError(1)
   EndIf
   If ControlClick("[CLASS:#32770]", "", "&None") Then
   Else
	  SetError(1)
   EndIf
   Local $myArray = StringSplit($filterItems, "|")
   For $a1 = 1 To (UBound($myArray) - 1)
	  ControlClick("[CLASS:#32770]", "", $myArray[$a1])
   Next
   ControlClick("[CLASS:#32770]", "", "OK")
EndFunc

Func filePathSelection()
   Local Const $sMessage = "Please select a destination for your PDF:"
   Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
   If @error Then
	  Return "Cancelled"
   Else
	  Return $sFileSelectFolder
   EndIf
EndFunc

Func exportToPDF($destination_select)
   Local $sMyFilePath = ""
   If $destination_select == True Then
	  $sMyFilePath = filePathSelection()
   EndIf
   If $sMyFilePath == "Cancelled" Then
	  Return
   Else
	  WinActivate("Finale")
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "Adva&nced Tools", "&Graphics")
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Graphics", "E&xport Pages...")
	  WinWait("Export Pages")
	  ControlCommand("Export Pages", "", "ComboBox2","SelectString", "PDF")
	  ControlClick("[CLASS:#32770]", "", "OK")
	  WinWaitActive("Save As")
	  WinActivate("Save As")
	  If $destination_select == True Then
		 Send("^c")
		 Send($sMyFilePath)
		 Send("{ENTER}")
		 Send("^v")
	  EndIf
	  ControlClick("[CLASS:#32770]", "", "&Save")
	  WinWaitActive("Confirm Save As", "", 1)
	  If WinExists("Confirm Save As") Then
		 ControlClick("[CLASS:#32770]", "", "&Yes")
	  EndIf
   EndIf
EndFunc

Func iterateThroughParts()
   Local $hWnd = WinGetHandle("[CLASS:Finale]")
   Local $hMain = _GUICtrlMenu_GetMenu($hWnd)
   Local $menuCount = _GUICtrlMenu_GetItemCount($hMain)
   WinMenuSelectItem("[CLASS:Finale]", "", "D&ocument", "Edit &Score")
   exportToPDF(True)
   For $a1 = 0 To  $menuCount
	  If _GUICtrlMenu_GetItemText($hMain, $a1) = "D&ocument" Then
		 Local $hFile = _GUICtrlMenu_GetItemSubMenu($hMain, $a1)
		 $submenuCount = _GUICtrlMenu_GetItemCount($hFile)
		 For $a2 = 0 To $submenuCount
			If _GUICtrlMenu_GetItemText($hFile, $a2) = "Edit &Part" Then
			   $subSubMenuItem = _GUICtrlMenu_GetItemSubMenu($hFile, $a2)
			   Local $subSubMenuCount = _GUICtrlMenu_GetItemCount($subSubMenuItem)
			   For $a3 = 0 To ($subSubMenuCount - 5)
				  Local $partName = _GUICtrlMenu_GetItemText($subSubMenuItem, $a3)
				  If StringInStr($partName, "Generate") Then
					 MsgError("You don't appear to have any parts generated. Please Generate Parts and try again.")
					 Return
				  Else
					 WinMenuSelectItem("[CLASS:Finale]", "", "D&ocument", "Edit &Part", $partName)
					 exportToPDF(False)
				  EndIf
			   Next
			EndIf
		 Next
	  EndIf
   Next
   WinMenuSelectItem("[CLASS:Finale]", "", "D&ocument", "Edit &Score")
EndFunc

Func KeySig($keySet, $maj_min)
   If ($maj_min = "Keyless") Or ($maj_min = "Nonstandard...") Then
      WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "&Key Signature")
      Send("{ENTER}")
      WinWaitActive("", "Key Signature", 1)
	  If WinExists("Key Signature") Then
		 ControlCommand("Key Signature", "", "ComboBox1","SelectString", $maj_min)
		 If $maj_min = "Keyless" Then
			ControlClick("[CLASS:#32770]", "", "OK")
		 EndIf
	  Else
		 SetError(1)
	  EndIf
   ElseIf ($keySet < 14) Or ($keySet > 0) Or ($maj_min = "Major") Or ($maj_min = "Minor") Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "&Key Signature")
	  Send("{ENTER}")
	  WinWaitActive("", "Key Signature", 1)
	  If WinExists("Key Signature") Then
		 Local $WindowPos = WinGetPos("[CLASS:#32770]")
		 MouseMove($WindowPos[0], $WindowPos[1], 0)
		 MouseWheel($MOUSE_WHEEL_UP, 14)
		 MouseWheel($MOUSE_WHEEL_DOWN, Number($keySet))
		 ControlCommand("Key Signature", "", "ComboBox1","SelectString", $maj_min & " Key")
		 ControlClick("[CLASS:#32770]", "", "OK")
	  Else
		 SetError(1)
	  EndIf
   Else
	  SetError(1)
   EndIf
EndFunc

Func ApplyMetatool($MenuName, $MenuItemName, $Metatool)
   If WinMenuSelectItem("[CLASS:Finale]", "", $MenuName, $MenuItemName) Then
	  Send($Metatool)
   Else
	  SetError(1)
   EndIf
EndFunc

Func LyricsWindow()
	WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "&Lyrics")
	If WinExists("[CLASS:#32770]", "Lyrics") Then
		WinClose("[CLASS:#32770]", "Lyrics")
	Else
		WinMenuSelectItem("[CLASS:Finale]", "", "L&yrics", "Lyrics &Window...")
	EndIf
 EndFunc

 Func ResizeNotes($noteSize)
	If WinMenuSelectItem("[CLASS:Finale]", "", "Uti&lities", "&Change", "Note &Size...") Then
	  Send($noteSize)
	  ControlClick("Change Note Size", "", "[CLASS:Button; INSTANCE:1]")
   Else
	  SetError(1)
   EndIf
EndFunc

Func SinglePitch($pitch)
	If WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "Note, Beam, and Rest Editing", "Single Pitch...") Then
	  WinWaitActive("", "Single Pitch", 1)
	  If WinExists("Single Pitch") Then
		 Send($pitch)
		 ControlClick("Single Pitch", "", "[CLASS:Button; INSTANCE:1]")
	  Else
		 SetError(1)
	  EndIf
   Else
	  SetError(1)
   EndIf
EndFunc

Func Transpose($direction, $chromOrDia, $interval, $preserveCheck)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Uti&lities", "&Transpose...") Then
	  WinWaitActive("", "Transposition", 1)
	  If WinExists("Transposition") Then
		 If $direction == "Up" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:4]")
		 ElseIf $direction == "Down" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:5]")
		 EndIf
		 If $chromOrDia == "Chromatically" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:7]")
			ControlCommand("Transposition", "", "[CLASS:ComboBox; INSTANCE:2]", "SelectString", $interval)
		 ElseIf $chromOrDia == "Diatonically" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:6]")
			ControlCommand("Transposition", "", "[CLASS:ComboBox; INSTANCE:1]", "SelectString", $interval)
		 EndIf
		 If $preserveCheck == False Then
			ControlCommand("Transposition", "", "Preserve &original notes", "UnCheck")
		 ElseIf $preserveCheck == True Then
			ControlCommand("Transposition", "", "Preserve &original notes", "Check")
		 EndIf
		 ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:1]")
	  Else
		 SetError(1)
	  EndIf
   Else
	  SetError(1)
   EndIf
EndFunc

Func ResetMarks($resetParam)
   $menuItem = 0
   If $resetParam == "Articulations" Then
	  $menuItem = "A&rticulations..."
   ElseIf $resetParam == "Expressions" Then
	  $menuItem = "&Expressions..."
   EndIf
   $resetParam = StringTrimRight($resetParam, 1)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Uti&lities", "&Change", $menuItem) Then
	  ControlClick("Change "&$resetParam&" Assignments", "", "Button4")
	  ControlCommand("Change "&$resetParam&" Assignments", "", "ComboBox1", "SelectString", "Add to Default Position")
	  ControlCommand("Change "&$resetParam&" Assignments", "", "Button7", "UnCheck")
	  ControlSetText("Change "&$resetParam&" Assignments", "", "Edit3", "0")
	  ControlSetText("Change "&$resetParam&" Assignments", "", "Edit4", "0")
  	  ControlClick("Change "&$resetParam&" Assignments", "", "Button1")
   Else
	  SetError(1)
   EndIf
EndFunc

Func RedefinePages($scope)
   If WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "&Page Layout") Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Page Layout", "&Redefine Pages", "&Selected Pages of Selected Parts/Score")
	  WinWaitActive("Redefine Selected Pages")
	  ControlClick("Redefine Selected Pages", "", "Button5")
	  ControlSetText("Redefine Selected Pages", "", "Edit1", 1)
	  ControlSetText("Redefine Selected Pages", "", "Edit2", "")
	  If $scope == "Score" Then
		 ControlCommand("Redefine Selected Pages", "", "ComboBox1", "SelectString", "Selected Parts/Score")
		 ControlClick("Redefine Selected Pages", "", "Button9")
		 WinWaitActive("Select Parts/Score")
		 ControlClick("Select Parts/Score", "", "Button4")
		 Local $hlistView = ControlGetHandle("Select Parts/Score", "", "SysListView321")
		 For $a1 = 0 To 5
			Send("{DOWN}")
		 Next
		 Sleep(500)
		 Send("{SPACE}")
		 ControlClick("Select Parts/Score", "", "Button1")
		 WinWaitActive("Redefine Selected Pages")
	  Else
		 ControlCommand("Redefine Selected Pages", "", "ComboBox1", "SelectString", $scope)
	  EndIf
	  ControlClick("Redefine Selected Pages", "", "Button6")
 	  WinWaitActive("", "Redefine Pages", 1)
	  If WinExists("Redefine Pages") Then
		 ControlClick("Redefine Pages", "", "Button3")
	  EndIf
  Else
	  SetError(1)
   EndIf
EndFunc

Func ComplexMeter($compNumerator, $compDenominator, $dispTimesig)

   Local $numeratorArray = StringSplit($compNumerator, "|")
   Local $denominatorArray = StringSplit($compDenominator, "|")
   Local $displaySig = StringSplit($dispTimesig, "|")

   If WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "Time Si&gnature") Then
	  Send("{ENTER}")
	  WinWaitActive("", "Time Signature", 1)
	  If WinExists("Time Signature") Then
		 ControlClick("Time Signature", "", "Button4")
		 WinWaitActive("Composite Time Signature")
		 ControlCommand("Composite Time Signature", "", "Button5", "UnCheck")
		 Local $i = 1
		 For $a1 = 1 To $numeratorArray[0]
			ControlSetText("Composite Time Signature", "", "Edit"&$i, $numeratorArray[$a1])
			   $i = $i + 1
			ControlSetText("Composite Time Signature", "", "Edit"&$i, $denominatorArray[$a1])
			$i = $i + 1
		 Next
		 ControlClick("Composite Time Signature", "", "Button1")
		 WinWaitActive("Time Signature")
		 If $dispTimesig <> "" Then
			ControlClick("Time Signature", "", "Button5")
			ControlCommand("Time Signature", "", "Button12", "Check")
			ControlClick("Time Signature", "", "Button13")
			WinWaitActive("Composite Time Signature")
			ControlClick("Composite Time Signature", "", "Button3")
			ControlClick("Composite Time Signature", "", "Button1")
			WinWaitActive("Time Signature")
			ControlClick("Time Signature", "", "ScrollBar3")
			For $a2 = 0 To 100
			   Send("{LEFT}")
			Next
			Local $rightDisp = Int($displaySig[1])
			For $a3 = 2 To $rightDisp
			   Send("{RIGHT}")
			Next
			Sleep(1000)
			ControlClick("Time Signature", "", "ScrollBar4")
			For $a4 = 0 To 10
			   Send("{LEFT}")
			Next

			If $displaySig[2] = 32 Then
			   $clicks = 0
			ElseIf $displaySig[2] = 64 Then
			   $clicks = 1
			ElseIf $displaySig[2] = 16 Then
			   $clicks = 2
			ElseIf $displaySig[2] = 8 Then
			   $clicks = 4
			ElseIf $displaySig[2] = 4 Then
			   $clicks = 6
			ElseIf $displaySig[2] = 2 Then
			   $clicks = 8
			ElseIf $displaySig[2] = 1 Then
			   $clicks = 10
			Else
				setError(1)
			 EndIf

			For $a5 = 1 To $clicks
			   Send("{RIGHT}")
			Next
			Sleep(1000)
		 EndIf
	   ControlClick("Time Signature", "", "Button1")
	Else
	   SetError(1)
	EndIf
   Else
	  SetError(1)
   EndIf
EndFunc

Func Colors($param)
	If WinMenuSelectItem("[CLASS:Finale]", "", "&View", "Select &Display Colors...") Then
	   WinWaitActive("Preferences - Display Colors")
	   If $param == "Toggle" Then
		  If ControlCommand("Preferences", "", "&Use score colors", "IsChecked") Then
		  ControlCommand("Preferences", "", "&Use score colors", "UnCheck")
		  ControlCommand("Preferences", "", "Color u&nlinked items", "UnCheck")
		  Else
			 ControlCommand("Preferences", "", "&Use score colors", "Check")
			 ControlCommand("Preferences", "", "Color u&nlinked items", "Check")
		  EndIf
	   ElseIf $param == "Colors" Then
		  ControlClick("Preferences", "", "&Use score colors")
	   ElseIf $param == "Unlinked" Then
		  ControlClick("Preferences", "", "Color u&nlinked items")
	   EndIf
	   ControlClick("Preferences", "", "OK")
	Else
	   SetError(1)
	EndIf
 EndFunc

 Func CustomLineSelect()
   If WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "Smart S&hape", "C&ustom Line Tool") Then
	  If WinMenuSelectItem("[CLASS:Finale]", "", "&SmartShape", "Smart Shape &Options...") Then
		 WinWaitActive("Smart Shape Options")
		 ControlCommand("Smart Shape Options", "", "ComboBox2", "SelectString", "Custom Line")
		 ControlClick("Smart Shape Options", "", "[CLASS:Button; INSTANCE:7]")
	  EndIf
   Else
	  SetError(1)
   EndIf
 EndFunc

Func TGTools($command)
   Local $hWnd = WinGetHandle("[CLASS:Finale]")
   Local $hMain = _GUICtrlMenu_GetMenu($hWnd)
   Local $menuCount = _GUICtrlMenu_GetItemCount($hMain)
   Local $TGFull = False

   For $a1 = 0 To  $menuCount
	  If _GUICtrlMenu_GetItemText($hMain, $a1) = "T&GTools" Then
		 $TGFull = True
	  EndIf
   Next

   If $TGFull = True Then
	  If $command = "Near" Then
		 Send("!{NUMPADADD}")
	  ElseIf $command = "Far" Then
		 Send("!{NUMPADSUB}")
	  ElseIf $command = "Align" Then
		 Send("!{NUMPADMULT}")
	  ElseIf $command == "Trem" Then
 		 WinMenuSelectItem("[CLASS:Finale]", "", "T&GTools", "M&usic", "&Tremolos...")
		 ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 6]")
		 ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 5]")
	  ElseIf $command == "Parts" Then
		 WinMenuSelectItem("[CLASS:Finale]", "", "T&GTools", "&Parts", "&Process extracted parts..")
		 ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 6]")
		 ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 5]")
	  EndIf
   Else
	  If ($command = "Near") Or ($command = "Far") Or ($command = "Align") Then
		 WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "TG Tools", "Align/Move Dynamics")
		 WinWaitActive("", "[CLASS:TDActOpt]", 1)

		 If $command = "Near" Then
			ControlClick("", "", "[CLASS:TGroupButton; INSTANCE: 4]")
		 ElseIf $command = "Far" Then
			ControlClick("", "", "[CLASS:TGroupButton; INSTANCE: 3]")
		 ElseIf $command = "Align" Then
			ControlClick("", "", "[CLASS:TGroupButton; INSTANCE: 2]")
		 EndIf
	  ElseIf $command = "Trem" Then
		 WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "TG Tools", "Easy Tremolos")
	  ElseIf $command = "Parts" Then
		 WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "TG Tools", "Process Extracted Parts")
	  EndIf
	  ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 4]")
	  ControlClick("", "", "[CLASS:TLMDButton; INSTANCE: 3]")
   EndIf
EndFunc

Func Quantize($resolution, $params)
   If WinMenuSelectItem("[CLASS:Finale]", "", "MI&DI/Audio", "&Quantization Settings...") Then
	  WinWaitActive("Quantization Settings")
	  ControlSetText("Quantization Settings", "", "Edit1", $resolution)
	  ControlCommand("Quantization Settings", "", "&"&$params, "Check")
	  ControlClick("Quantization Settings", "", "OK")
	  ;WinWait("Finale")
	  ;If Not WinActive("Finale") Then WinActivate("Finale")
	  WinWaitActive("Finale")
	  WinMenuSelectItem("[CLASS:Finale]", "", "MI&DI/Audio", "R&etranscribe")
   Else
		SetError(1)
   EndIf
EndFunc

Func ProcessExtracted($topBottom, $singleNotes, $lineNumber)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "TG Tools", "Process Extracted Parts...") Then
	  If $topBottom == "Top" Then
		 ControlClick("", "", "[CLASS:TGroupButton; INSTANCE:2]")
	  ElseIf $topBottom == "Bottom" Then
		 ControlClick("", "", "[CLASS:TGroupButton; INSTANCE:1]")
	  EndIf
	  If $singleNotes == True Then
		 ControlCommand("", "", 1706120, "Check")
	  ElseIf $singleNotes == False Then
		 Send("{TAB} ")
		 ;ControlCommand("", "", "[CLASS:TLMDCheckBox; INSTANCE:1]", "UnCheck")
	  EndIf
	  ControlSetText("", "", "[CLASS:TMyEdit; INSTANCE:1]", $lineNumber)
	  ControlClick("", "", "[CLASS:TLMDButton; INSTANCE:4]")
	  WinWaitActive("Finale", "", 1)
	  If WinExists("Finale") Then
		 ControlClick("", "&Yes", "[CLASS:Button; INSTANCE:1]")
	  EndIf
	  ControlClick("", "", "[CLASS:TLMDButton; INSTANCE:3]")
   Else
	  SetError(1)
   EndIf
EndFunc

Func CheckForUpdate($SDsize, $currentVersion)
	$sWebSite = "http://jetstreamfinale.com/twdmmfc0z1g345d7s5/"
   $sHtml =  _INetGetSource($sWebSite)
   If $sHtml Then
	  If $SDsize = "Standard" Then
		 $aNewVersion = StringRegExp($sHtml, "https://www.dropbox.com/s/.*/JetStream%20Win%2015key%\d.*\.", $STR_REGEXPARRAYMATCH)
		 $sNewVersionNumber = StringTrimRight(StringRight($aNewVersion[0], 7), 1)
	  ElseIf $SDsize = "XL" Then
		 $aNewVersion = StringRegExp($sHtml, "https://www.dropbox.com/s/.*/JetStream%20Win%20proXL%\d.*\.", $STR_REGEXPARRAYMATCH)
		 $sNewVersionNumber = StringTrimRight(StringRight($aNewVersion[0], 7), 1)
	  EndIf

	  If Number($sNewVersionNumber) = Number($currentVersion) Then
		 MsgBox($MB_OK, "No Update Available", "You're up to date with the current version: " & $sNewVersionNumber & @CRLF & @CRLF & "Please check back again soon for a new version.")
		 Return
	  Else
		 If $SDsize = "Standard" Then
			$aLinkArray = StringRegExp($sHtml, "https://www.dropbox.com/s/.*/JetStream%20Win%2015key%\d.*\.zip\?dl=1", $STR_REGEXPARRAYMATCH)
		 ElseIf $SDsize = "XL" Then
			$aLinkArray = StringRegExp($sHtml, "https://www.dropbox.com/s/.*/JetStream%20Win%20proXL%\d.*\.zip\?dl=1", $STR_REGEXPARRAYMATCH)
		 EndIf
		 $sDownloadLink = $aLinkArray[0]

		 If Number($currentVersion) > Number($sNewVersionNumber) Then
			Local $msgBox = MsgBox($MB_OK, "An odd thing has happened", "You seem to have a version that is newer than the one we are currently offering... How'd you do that?" & @CRLF & @CRLF & "Let's get you back on the right track with the current build.")
			ShellExecute($sDownloadLink)
		 Else
			Local $msgBox = MsgBox($MB_YESNO, "An update is available!", "You currently have version: " & $currentVersion & @CRLF & @CRLF & "Would you like to update to version: " & $sNewVersionNumber & "?")
			If $msgBox = 6 Then
				ShellExecute($sDownloadLink)
			Else
				Return
			EndIf
		 EndIf
	 EndIf
   	Else
		SetError(1)
   	EndIf
EndFunc

Func CheckIfActive()
   If $CmdLine[1] = "Lua" Then
	  LuaMenu($CmdLine[2])
	  If @error Then
		 MsgError("The JetStream command couldn't be completed." & @CRLF & @CRLF & "Please be sure you have a region selected and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Menu" Then
	  MenuItem($CmdLine[2], $CmdLine[3])
	  If @error Then
		 MsgError("The menu item " & $CmdLine[3] & " wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Submenu" Then
	  SubmenuItem($CmdLine[2], $CmdLine[3], $CmdLine[4])
	  If @error Then
		 MsgError("The menu item " & $CmdLine[4] & " wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Subsubmenu" Then
	  SubsubmenuItem($CmdLine[2], $CmdLine[3], $CmdLine[4], $CmdLine[5])
	  If @error Then
		 MsgError("The menu item " & $CmdLine[5] & " wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf ($CmdLine[1] = "Filter") Or ($CmdLine[1] = "Clear") Then
	  FilterItems($CmdLine[1], $CmdLine[2])
	  If @error Then
		 MsgError("Unable to set or clear the Filter." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "PDF" Then
	  If $CmdLine[2] = "Current" Then
		 exportToPDF(True)
	  ElseIf $CmdLine[2] = "Both" Then
		 iterateThroughParts()
	  EndIf
	  If @error Then
		 MsgError("Unable to export parts and score to PDF." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Key" Then
	  KeySig($CmdLine[2], $CmdLine[3])
	  If @error Then
		 MsgError("Unable to change the Key Signature." & @CRLF & @CRLF & "Please be sure your document is in focus and you have a region selected and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Metatool" Then
	  ApplyMetatool($CmdLine[2], $CmdLine[3], $CmdLine[4])
	  If @error Then
		 MsgError("The metatool " & $CmdLine[4] & "wasn't able to be applied." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Lyrics Window" Then
	  LyricsWindow()
	  If @error Then
		 MsgError("The " & $CmdLine[1] & " toggle function failed." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Resize Notes" Then
	  ResizeNotes($CmdLine[2])
	  If @error Then
		 MsgError("Unable to resize notes." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Single Pitch" Then
	  SinglePitch($CmdLine[2])
	  If @error Then
		 MsgError("Unable to set notes to a single pitch." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Transpose" Then
	  Transpose($CmdLine[2], $CmdLine[3], $CmdLine[4], $CmdLine[5])
	  If @error Then
		 MsgError($CmdLine[1] & " wasn't able to be selected." & @CRLF & @CRLF & "Please be sure the region you selected is using a Standard Notation Style and that Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Reset Marks" Then
	  ResetMarks($CmdLine[2])
	  If @error Then
		 MsgError("Unable to reset " & $CmdLine[2] & "."& @CRLF & @CRLF & "Please be sure you have a region selected and that Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Redefine Pages" Then
	  RedefinePages($CmdLine[2])
	  If @error Then
		 MsgError("Unable to " & $CmdLine[1] & "."& @CRLF & @CRLF & "Please be sure that Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Complex Meter" Then
	  ComplexMeter($CmdLine[2], $CmdLine[3], $CmdLine[4])
	  If @error Then
		 MsgError("Unable to create a " & $CmdLine[1] & "."& @CRLF & @CRLF & "Please be sure you have a region selected and that Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Colors" Then
		Colors($CmdLine[2])
		If @error Then
			MsgError("Unable to change display colors."& @CRLF & @CRLF & "Please be sure you have Finale is in focus and try again.")
		 EndIf
   ElseIf $CmdLine[1] = "TGTools" Then
	  TGTools($CmdLine[2])
	  If @error Then
		 MsgError("Unable to align dynamics."& @CRLF & @CRLF & "Please be sure you have Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Quantize" Then
	  Quantize($CmdLine[2], $CmdLine[3])
	  If @error Then
		 MsgError("Unable to align dynamics."& @CRLF & @CRLF & "Please be sure you have Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Custom Line" Then
	  CustomLineSelect()
	  If @error Then
		 MsgError("Unable to select the custom line dialog."& @CRLF & @CRLF & "Please be sure you have Finale is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Process Extracted" Then
	  ProcessExtracted($CmdLine[2], $CmdLine[3], $CmdLine[4])
	  If @error Then
		 MsgError("Unable to completed Process Extracted Parts."& @CRLF & @CRLF & "Please be sure you have Finale is in focus and try again.")
	  EndIf
   EndIf
EndFunc


If $CmdLine[1] = "Update" Then
	CheckForUpdate($CmdLine[2], $CmdLine[3])
   If @error Then
	  MsgError("Check for update failed." & @CRLF & @CRLF & "Please be sure you connected to the internet and try again.")
   EndIf
Else
   Local $active = WinGetProcess("[ACTIVE]")
   Local $aProcesses = ProcessList()
   For $i = 1 To $aProcesses[0][0]
	  Local $myResult = StringInStr($aProcesses[$i][0], "Finale")
	  If $myResult = 1 then
		 If $active = $aProcesses[$i][1] Then
			CheckIfActive()
		 Else
			MsgError("Please make sure Finale is the front application.")
		 EndIf
	  EndIf
   Next
EndIf