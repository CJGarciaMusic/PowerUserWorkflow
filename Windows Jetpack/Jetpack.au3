#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Author: CJ Garcia
 Script Function: Stream Deck Finale Jetpack UI automation tools for Windows
#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <GuiMenu.au3>

Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

CheckIfActive()

Func MsgError($text)
    MsgBox($MB_OK, "StreamDeck Error", $text)
EndFunc


Func LuaMenu($luaNum)
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4])
   Send($luaNum)
   ControlClick ("[CLASS:#32770]", "", "OK")
EndFunc

Func MenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3])
EndFunc


Func SubmenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4])
EndFunc


Func SubsubmenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4], $CmdLine[5])
EndFunc


Func FilterItems($actionType)
   If $actionType = "Filter" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Edit Filter...")
   ElseIf $actionType = "Clear" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Cl&ear Selected Items...")
   EndIf
   ControlClick("[CLASS:#32770]", "", "&None")
   Local $myArray = StringSplit($CmdLine[2], "|")
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


Func CheckIfActive()
    Local $frontWin = WinGetTitle("[ACTIVE]")
    Local $myResult = StringInStr($frontWin, "Finale")
    If $myResult = 1 Then
      If $CmdLine[1] = "Lua" Then
		 LuaMenu($CmdLine[5])
	  ElseIf $CmdLine[1] = "Menu" Then
		 MenuItem()
	  ElseIf $CmdLine[1] = "Submenu" Then
		 SubmenuItem()
	  ElseIf $CmdLine[1] = "Subsubmenu" Then
		 SubsubmenuItem()
	  ElseIf ($CmdLine[1] = "Filter") Or ($CmdLine[1] = "Clear") Then
		 FilterItems($CmdLine[1])
	  ElseIf $CmdLine[1] = "PDF" Then
		 iterateThroughParts()
	  EndIf
	Else
        MsgError("Finale does not appear to be in focus. Please try again.")
    EndIf
EndFunc