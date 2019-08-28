#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Author: CJ Garcia
 Version: 190827
 Script Function: JetStream Finale Controller for Windows
#ce -------------------------\]---------------------------------------------------
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <GuiMenu.au3>
#include <String.au3>
#include <INet.au3>

Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

Func MsgError($text)
    MsgBox($MB_OK, "JetStream has encountered some turbulence...", $text)
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
   If ($keySet > 14) Or ($keySet < 0) Or ($maj_min <> "Major") Or ($maj_min <> "Minor") Then
	  SetError(1)
   Else
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Tools", "&Key Signature")
	  Send("{ENTER}")
	  WinWaitActive("[CLASS:#32770]", "", "Key Signature")
	  Local $WindowPos = WinGetPos("[CLASS:#32770]")
	  MouseMove($WindowPos[0], $WindowPos[1], 0)
	  MouseWheel($MOUSE_WHEEL_UP, 14)
	  MouseWheel($MOUSE_WHEEL_DOWN, Number($keySet))
	  ControlCommand("Key Signature", "", "ComboBox1","SelectString", $maj_min & " Key")
	  ControlClick("[CLASS:#32770]", "", "OK")
   EndIf
EndFunc

Func ApplyMetatool($MenuName, $MenuItemName, $Metatool)
   If WinMenuSelectItem("[CLASS:Finale]", "", $MenuName, $MenuItemName) Then
	  Send($Metatool)
   Else
	  SetError(1)
   EndIf
EndFunc

Func CheckForUpdate()
   Local $currentVersion = 190828

   $sHtml =  _INetGetSource("http://www.musicprep.com/jetstream/")
   If $sHtml Then
	  $sStart = "WINDOWS STREAM DECK PROFILE VERSION "
	  $sEnd = "</a>"

	  $Array1 = _StringBetween ($sHtml, $sStart, $sEnd)
	  _ArrayToClip ($Array1)
	  $result = (ClipGet())

	  If $result = $currentVersion Then
		 MsgBox($MB_OK, "", "You're up to date with the current version " & $result)
		 Return
	  Else
		 Local $msgBox = MsgBox($MB_YESNO, "An update is available!", "You currently have version " & $currentVersion & @CRLF & @CRLF & "Would you like to update to version " & $result & "?")
		 If $msgBox = 6 Then
			ShellExecute("http://www.musicprep.com/jetstream/")
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
	  iterateThroughParts()
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
   EndIf
EndFunc

If $CmdLine[1] = "Update" Then
   CheckForUpdate()
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
			MsgError("Finale does not appear to be in focus. Please try again.")
			Return
		 EndIf
	  EndIf
   Next
EndIf
