ChangeFolderTypeDialog()
{
  global
  IfWinExist, Misc Actions ahk_class AutoHotkeyGUI
  {
    WinActivate, Misc Actions ahk_class AutoHotkeyGUI
    return
  }
  
  Gui, 2:Add, Text
    , % "x10 y12"
    . " vMiscACtions_ChangeFolderType_Text1"
    , % "Number of Folders to modify:"
  GuiControlGet, result, 2:Pos, MiscActions_ChangeFolderType_Text1
  
  Gui, 2:Add, Edit
    , % "x" . ResultW + 20
    . " y10"
    . " vMiscACtions_ChangeFolderType_NoFolders"
    . " w30 Right"
  
  GuiControlGet, result2, 2:Pos, MiscActions_ChangeFolderType_NoFolders
  
  Gui 2:Add, Button
    , % "x"  . (10 + ResultW + Result2W + 20 - 120) / 2
    . " w120 h30"
    . " +default"
    . " gMiscActions_ChangeFolderType_SubmitH"
    , % "OK"
  
  Gui, 2:Show
    , 
    , Misc Actions
  
  return
}

GoTo, MiscActionsEndScript

MiscActions_ChangeFolderType_SubmitH:
{
  GuiControlGet, result, 2: , MiscActions_ChangeFolderType_NoFolders
  if result is integer
  {
    if (result > 0 && result <= 30)
    {
      Gui, 2:Destroy
      ChangeFoldersType(result)
    }else
    {
      MsgBox, % "Please specify an integer >0 and <= 30"
    }
  }else
  {
    MsgBox, % "invalid input: " . result
  }
  return
}

ChangeFoldersType(n)
{
  MouseSpeed := 2
  ActionDelay := 200
  
  Sleep, 2000
  ExplorerWindowID := WaitUntilWindowActive("ahk_class CabinetWClass", 6, 500)
  ExplorerWindow := "ahk_id " . ExplorerWindowID
  
  if (!ExplorerWindowID)
  {
    MsgBox, No Explorer Window Selected. Canceling action.
    return
  }
  
  ChangeFolderType(ExplorerWindow, MouseSpeed, ActionDelay)
  
  Loop, % n - 1
  {
    SleepIf(ActionDelay)
    WinActivate, % ExplorerWindow
    send, {Right}
    ChangeFolderType(ExplorerWindow, MouseSpeed, ActionDelay)
  }
}

ChangeFolderType(ExplorerWindow, MouseSpeed, ActionDelay)
{
  global
  local PropertiesWindowID
  local PropertiesWindow
  
  SleepIf(ActionDelay)
  WinActivate, % ExplorerWindow
  send, !{Enter}
  
  SetTitleMatchMode 2
  PropertiesWindowID := WaitUntilWindowActive("Properties ahk_class #32770", 10, 200)
  PropertiesWindow := "ahk_id " . PropertiesWindowID
  SetTitleMatchMode 1
  if (!PropertiesWindowID)
  {
    return
  }
  
  SleepIf(ActionDelay)
  WinActivate, % PropertiesWindow
  send, ^+{TAB}
  
  SleepIf(ActionDelay)
  WinActivate, % PropertiesWindow
  send, !{DOWN}
  
  SleepIf(ActionDelay)
  WinActivate, % PropertiesWindow
  MouseClick
    , left
    , % "100"
    , % "180"
    , , % MouseSpeed
  
  SleepIf(ActionDelay)
  WinActivate, % PropertiesWindow
  send, {ENTER}
}

2GuiClose:
  Gui, 2:Destroy
  return

MiscActionsEndScript:



