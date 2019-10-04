#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Version: 190908
 Script Function: JetStream Finale Controller for Windows
#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <GuiMenu.au3>
#include <GuiListView.au3>
#include <String.au3>
#include <INet.au3>

Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

Func MsgError($text)
    MsgBox($MB_OK, "JetStream Alert", $text)
EndFunc

Func LuaMenu($luaNum)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Plug-&ins", "JW Lua", "JetStream Finale Controller") Then
	  If WinGetTitle("JetStream Finale Controller") Then
		 Send($luaNum)
		 ControlClick("[CLASS:#32770]", "", "OK")
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

Func exportToPDF()
   WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "Adva&nced Tools", "&Graphics")
   WinMenuSelectItem("[CLASS:Finale]", "", "&Graphics", "E&xport Pages...")
   WinWait("Export Pages")
   ControlCommand("Export Pages", "", "ComboBox2","SelectString", "PDF")
   ControlClick("[CLASS:#32770]", "", "OK")
   WinWaitActive("Save As")
   WinActivate("Save As")
   ControlClick("[CLASS:#32770]", "", "&Save")
   WinWaitActive("Confirm Save As", "", 1)
   If WinExists("Confirm Save As") Then
	  ControlClick("[CLASS:#32770]", "", "&Yes")
   EndIf
EndFunc

Func iterateThroughParts()
   Local $hWnd = WinGetHandle("[CLASS:Finale]")
   Local $hMain = _GUICtrlMenu_GetMenu($hWnd)
   Local $menuCount = _GUICtrlMenu_GetItemCount($hMain)
   WinMenuSelectItem("[CLASS:Finale]", "", "D&ocument", "Edit &Score")
   exportToPDF()
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
					 exportToPDF()
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
	If WinExists("Lyrics") Then
		WinClose("Lyrics")
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

Func Transpose($direction, $chromOrDia, $interval)
   If WinMenuSelectItem("[CLASS:Finale]", "", "Uti&lities", "&Transpose...") Then
	  WinWaitActive("", "Transposition", 1)
	  If WinExists("Transposition") Then
		 If $direction == "Up" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:4]")
		 ElseIf $direction == "Down" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:5]")
		 EndIf
		 If $chromOrDia = "Chromatically" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:7]")
			ControlCommand("Transposition", "", "[CLASS:ComboBox; INSTANCE:2]", "SelectString", $interval)
		 ElseIf $chromOrDia = "Diatonically" Then
			ControlClick("Transposition", "", "[CLASS:Button; INSTANCE:6]")
			ControlCommand("Transposition", "", "[CLASS:ComboBox; INSTANCE:1]", "SelectString", $interval)
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

Func CheckForUpdate($currentVersion)
	$sWebSite = "http://jetstreamfinale.com/download/"
   $sHtml =  _INetGetSource($sWebSite)
   If $sHtml Then
	  $sStart = "WINDOWS JETSTREAM PROFILE "
	  $sEnd = "</p>"
	   $Array1 = _StringBetween($sHtml, $sStart, $sEnd)
	  _ArrayToClip($Array1)
	  $result = ClipGet()
	  If $result = $currentVersion Then
		 MsgBox($MB_OK, "", "You're up to date with the current version: " & $result)
		 Return
	  Else
		 Local $msgBox = MsgBox($MB_YESNO, "An update is available!", "You currently have version: " & $currentVersion & @CRLF & @CRLF & "Would you like to update to version: " & $result & "?")
		 If $msgBox = 6 Then
			ShellExecute($sWebSite)
		 Else
			Return
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
		 MsgError("The menu item " & $CmdLine[3] & "wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Submenu" Then
	  SubmenuItem($CmdLine[2], $CmdLine[3], $CmdLine[4])
	  If @error Then
		 MsgError("The menu item " & $CmdLine[4] & "wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "Subsubmenu" Then
	  SubsubmenuItem($CmdLine[2], $CmdLine[3], $CmdLine[4], $CmdLine[5])
	  If @error Then
		 MsgError("The menu item " & $CmdLine[5] & "wasn't able to be selected." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf ($CmdLine[1] = "Filter") Or ($CmdLine[1] = "Clear") Then
	  FilterItems($CmdLine[1], $CmdLine[2])
	  If @error Then
		 MsgError("Unable to set or clear the Filter." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
	  EndIf
   ElseIf $CmdLine[1] = "PDF" Then
	  Local $msgBox = MsgBox($MB_YESNO, "Export to PDF", "Are you sure you want to continue with exporting all parts and score as a PDF?")
	  If $msgBox = 6 Then
		 iterateThroughParts()
		 If @error Then
			MsgError("Unable to export parts and score to PDF." & @CRLF & @CRLF & "Please be sure your document is in focus and try again.")
		 EndIf
	  Else
		 Return
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
	  Transpose($CmdLine[2], $CmdLine[3], $CmdLine[4])
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
   EndIf
EndFunc

If $CmdLine[1] = "Update" Then
	CheckForUpdate(190928)
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
