#Include Utils.ahk
#Include ChangeTheme.ahk
#Include MiscACtions.ahk

/*
openes a dialog box to do a quick action
initialize the dialog box with
MainFrame.Create()

*/

global OpenFolderPannel := new OpenFolderPannelClass("Open a Folder")
global OpenProgramPannel := new OpenProgramPannelClass("Open a Program")
global ChangeThemePannel := new ChangeThemePannelClass("Choose a Color Theme")
global MiscActionsPannel := new MiscActionsPannelClass("Choose an action")
global UselessButtonPannel := new UselessButtonPannelClass("Do Something Useless")

class MainFrame
{
  static ActionPannels := Object()
  static ActivatedActionPannelIndex := 0
  
  static ToHide := 0
  
  InitiateStaticArrays()
  {
    this.ActionPannels.Insert(OpenFolderPannel)
    this.ActionPannels.Insert(OpenProgramPannel)
    this.ActionPannels.Insert(ChangeThemePannel)
    this.ActionPannels.Insert(MiscActionsPannel)
    this.ActionPannels.Insert(UselessButtonPannel)
  }
  
  Create()
  {
    MainPannel.Create()
    
    ActionPannel.PosX := MainPannel.Width
    ActionPannel.PosY := 0
    
    ActionPannel.CreateBox()

    For index, pannel in this.ActionPannels
    {
      pannel.CreateContent()
    }
  }
  
  Show()
  {
    this.ToHide := 0
    IfWinExist, QuickAction ahk_class AutoHotkeyGUI
    {
      WinActivate, QuickAction ahk_class AutoHotkeyGUI
      return
    }
    Animation.CurrentWidth := MainPannel.Width
    Animation.CurrentHeight := MainPannel.Height
    Gui, Show
      , % "w" . MainPannel.Width
      . " h" .  MainPannel.Height
      , QuickAction
  }
  
  Hide()
  {
    this.ToHide := 1
    MainPannel.SelectAction(0)
  }
  
  ActivateActionPannel(Index)
  {
    if(Index = this.ActivatedActionPannelIndex)
      return
    
    if(this.ActivatedActionPannelIndex != 0)
    {
      this.ActionPannels[this.ActivatedActionPannelIndex].Deactivate()
    }else
    {
      ;deactivate all
      For i, elem in this.ActionPannels
      {
        elem.Deactivate()
      }
    }
    
    if(Index != 0)
    {
      this.ActionPannels[Index].Activate()
    }
    this.ActivatedActionPannelIndex := Index
  }
}
MainFrame.InitiateStaticArrays()

; manages the width and height animation of the window (main frame)
class Animation
{
  static DurationMs := 500
  static TimeStep := 15
  static Time := 0
  static EaseFunction := Func("EaseInOutCubic")
  
  static InitialWidth
  static CurrentWidth
  static TargetWidth
  static DeltaWidth
  
  static InitialHeight
  static CurrentHeight
  static TargetHeight
  static DeltaHeight
  
  StartAnimation(targetWidth, targetHeight)
  {
    SetTimer, AnimationStepLabel, OFF
    
    this.Time := 0
    
    this.TargetWidth := targetWidth
    this.InitialWidth := this.CurrentWidth
    this.DeltaWidth := this.targetWidth - this.CurrentWidth
    
    this.TargetHeight := targetHeight
    this.InitialHeight := this.CurrentHeight
    this.DeltaHeight := this.targetHeight - this.CurrentHeight
    
    
    SetTimer, AnimationStepLabel, % this.TimeStep
    return
  }
  
  ; action at a "frame" of the animation
  DoStep()
  {
    duration := this.DurationMs / this.TimeStep
    
    this.currentWidth := this.EaseFunction.(this.Time, this.InitialWidth, this.DeltaWidth, duration)
    this.currentHeight := this.EaseFunction.(this.Time, this.InitialHeight, this.DeltaHeight, duration)
    Gui, Show, % "NoActivate" . " w" . this.currentWidth . " h" . this.currentHeight,
    
    this.Time += 1
    
    if (this.Time > duration)
    {
      SetTimer, AnimationStepLabel, OFF
      Gui, Show, % "NoActivate" . " w" . this.TargetWidth . " h" . this.targetHeight,
      this.currentWidth := this.TargetWidth
      this.currentHeight := this.Targetheight
      
      if (MainFrame.ToHide = 1)
      {
        Gui, Cancel
      }
    }
    
    return
  }
}

global BtnOpenF
global BtnOpenP
global BtnChangeTheme

; contains the index in an array of buttons,
; text label, variale and handler name
; has methods to make the button selected and deselected
class Button
{
  __New(Index, Label, FunctionH, Variable = "")
  {
    this.Index := Index
    this.Label := Label
    this.variable := Variable
    this.FunctionH := FunctionH
  }
  
  MakeSelected()
  {
    Gui, Font, % MainPannel.SelectedFont
    GuiControl, Font, % this.variable
    GuiControl, disable, % this.variable
    Gui, Font, 
  }
  
  MakeDeselected()
  {
    Gui, Font, 
    GuiControl, Font, % this.variable
    GuiControl, enable, % this.variable
  }
}

; the (left) pannel, in withch you select the main category
class MainPannel
{
  
  static ActionButtons := [new Button(1, "Open a Folder", "OpenFH", "BtnOpenF")
    ,new Button(2, "Open a Program", "OpenPH", "BtnOpenP")
    ,new Button(3, "Change Theme", "ChangeThemeH", "BtnChangeTheme")
    ,new Button(4, "Misc Actions", "MiscActionsH", "BtnMiscActions")
    ,new Button(5, "Useless Button", "UselessButtonH", "BtnUseless")]
  
  static BoxLabel := "Actions"
  
  static BoxVMargin := 5
  static BoxHMargin := 5
  
  static BoxTopExtraPadding := 12
  static BoxVPadding := 5
  static BoxHPadding := 5
  
  static ButtonWidth := 120
  static ButtonHeight := 30

  static ButtonVMargin := 5
  static ButtonHMargin := 5
  
  static SelectedButtonIdx := 0
  
  static SelectedFont := "underline"
  
  static Height
  static Width
  
  ; creates the pannel in the gui
  Create()
  {
    global
    local currentY := this.BoxVMargin + this.BoxTopExtraPadding + this.BoxVPadding + this.ButtonVMargin

    For index, button in this.ActionButtons
    {  
      Gui, Add, Button
        , % "x" . (this.BoxHMargin + this.BoxHPadding + this.ButtonHMargin)
        . " y" . currentY
        . " w" . this.ButtonWidth
        . " h" . this.ButtonHeight
        . " g" . button.FunctionH
        . " v" . button.Variable
        , % button.Label
      currentY += this.ButtonHeight + this.ButtonVMargin * 2
    }
    local BoxWidth := this.BoxHPadding * 2 + this.ButtonWidth + this.ButtonHMargin * 2
    local BoxHeight := this.BoxTopExtraPadding + this.BoxVPadding * 2
      + this.ActionButtons.MaxIndex() * (this.ButtonHeight + this.ButtonVMargin * 2)

    Gui, Add, GroupBox
      , % "x" . this.BoxHMargin
      . " y" . this.BoxVMargin
      . " w" . BoxWidth
      . " h" . BoxHeight
      , % this.BoxLabel

    this.Width := 2 * this.BoxHMargin + BoxWidth
    this.Height := 2 * this.BoxVMargin + BoxHeight

    Animation.CurrentWidth := this.Width
    Animation.CurrentHeight := this.Height
  }
  
  ; fired when a main button is pressed
  ; it is responsable to select / deselect the buttons,
  ; and to show the corrensponding action pannel
  
  SelectAction(ButtonIdx)
  {
    if (ButtonIdx != 0 && MainFrame.ToHide = 1)
    {
      return
    }
    
    ; make the buttons selected / deselected
    if (this.SelectedButtonIdx != 0)
    {
      this.ActionButtons[this.SelectedButtonIdx].MakeDeselected()
    }
    
    if (ButtonIdx != 0)
    {
      this.ActionButtons[ButtonIdx].MakeSelected()
    }
    
    this.SelectedButtonIdx := ButtonIdx
    
    ; activate (show) / deactivate action pannels
    if (ButtonIdx != 0)
    {
      MainFrame.ActivateActionPannel(ButtonIdx)
    }else
    {
      MainFrame.ActivatedActionPannelIndex := 0
    }
    
    ;animate to the new width and height
    if (ButtonIdx = 0)
    {
      NewHeight := this.Height
      NewWidth := this.Width
    }else
    {
      if (this.Height > MainFrame.ActionPannels[ButtonIdx].Height)
      {
        NewHeight := this.Height
      }else
      {
        NewHeight := MainFrame.ActionPannels[ButtonIdx].Height
      }
      NewWidth := MainPannel.Width + MainFrame.ActionPannels[ButtonIdx].Width
    }
    
    Animation.StartAnimation(NewWidth, NewHeight)
  }
}

; the pannel with the specific action
class ActionPannel
{
  static BoxName := "ActionPannelBox"
  
  static BoxVMargin := MainPannel.BoxVMargin
  static BoxHMargin := MainPannel.BoxHMargin
  
  static BoxTopExtraPadding := MainPannel.BoxTopExtraPadding
  static BoxVPadding := MainPannel.BoxVPadding
  static BoxHPadding := MainPannel.BoxHPadding
  
  static Height
  static Width
  
  static PosX
  static PosY
  
  __New(Label)
  {
    this.Label := Label
  }
  
  CreateBox()
  {
    global
    
    Gui, Add, GroupBox
      , % "x" . (this.PosX + this.BoxHMargin)
      . " y" . this.BoxVMargin
      . " w100"
      . " h100"
      . " v" . this.BoxName
  }
  
  ActivateBox()
  {
    global
    GuiControl, Text, % this.BoxName, % this.Label
    GuiControl, Move, % this.BoxName
      , % "w" + this.Width - this.BoxHMargin * 2
      . " h" . this.Height - this.BoxVMargin * 2
  }
}


class OpenFolderPannelClass extends ActionPannel
{
  OwnWidth := 0
  OwnHeight := 0
  CreateContent()
  {
    global
    Gui, Add, Text
      , % "x" . this.PosX + this.BoxHMargin + this.BoxHPadding
      . " y" . this.PosY + this.BoxVMargin + this.BoxVPadding + this.BoxTopExtraPadding
      . " vOpenFolderPannel_LiveTxt Hidden"
      , % "No one lives forever but you will live a short life"
    
    GuiControlGet, result, Pos, OpenFolderPannel_LiveTxt
    
    this.OwnWidth := this.BoxHMargin * 2 + resultW + this.BoxHPadding * 2
    this.OwnHeight := this.BoxVMargin * 2 + resultH + this.BoxVPadding * 2 + this.BoxTopExtraPadding
  }
  Activate()
  {
    ActionPannel.Width := this.OwnWidth
    ActionPannel.Height := this.OwnHeight
    
    GuiControl, Show, OpenFolderPannel_LiveTxt
    
    this.ActivateBox()
  }
  
  Deactivate()
  {
    GuiControl, Hide, OpenFolderPannel_LiveTxt
  }
}

class OpenProgramPannelClass extends ActionPannel
{
  OwnWidth := 0
  OwnHeight := 0
  CreateContent()
  {
    global
    Gui, Add, Text
      , % "x" . this.PosX + this.BoxHMargin + this.BoxHPadding
      . " y" . this.PosY + this.BoxVMargin + this.BoxVPadding + this.BoxTopExtraPadding
      . " vOpenProgramPannel_KiddingTxt Hidden"
      , % "Just kidding. You will live a long but ugly life"
    
    GuiControlGet, result, Pos, OpenProgramPannel_KiddingTxt
    
    this.OwnWidth := this.BoxHMargin * 2 + resultW + this.BoxHPadding * 2
    this.OwnHeight := this.BoxVMargin * 2 + resultH + this.BoxVPadding * 2 + this.BoxTopExtraPadding
  }
  Activate()
  {
    ActionPannel.Width := this.OwnWidth
    ActionPannel.Height := this.OwnHeight
    
    GuiControl, Show, OpenProgramPannel_KiddingTxt
    
    this.ActivateBox()
  }
  
  Deactivate()
  {
    GuiControl, Hide, OpenProgramPannel_KiddingTxt
  }
}

class ChangeThemeProgram
{
  static IconVariablePrefix := "Icon"
  static CheckBoxVariablePrefix := "Chk"
  
  __New(Name, Icon, VariableBaseName)
  {
    this.Name := Name
    this.Icon := Icon
    this.VariableBaseName := VariableBaseName
    this.IconVariable := this.IconVariablePrefix . VariableBaseName
    this.CheckBoxVariable := this.CheckBoxVariablePrefix . VariableBaseName
  }
}

class ChangeThemePannelClass extends ActionPannel
{
  OwnWidth := 0
  OwnHeight := 0
  
  static ChangeThemeButtons := [new Button(1, "Red", "ChangeThemeRedH", "BtnChangeThemeRed")
    ,new Button(2, "Green", "ChangeThemeGreenH", "BtnChangeThemeGreen")
    ,new Button(3, "Blue", "ChangeThemeBlueH", "BtnChangeThemeBlue")
    ,new Button(4, "Orange", "ChangeThemeOrangeH", "BtnChangeThemeOrange")
    ,new Button(5, "Black", "ChangeThemeBlackH", "BtnChangeThemeBlack")]
  
  static Programs := [new ChangeThemeProgram("Windows", "taskbar.ico", "Windows")
    ,new ChangeThemeProgram("Winamp", "winamp.ico", "Winamp")
    ,new ChangeThemeProgram("MiniLyrics", "MiniLyrics.ico", "MiniLyrics")
    ,new ChangeThemeProgram("ObjectDock", "ObjectDock_Blue.ico", "ObjectDock")]
  
  static ButtonWidth := 120
  static ButtonHeight := 30

  static ButtonVMargin := 5
  static ButtonHMargin := 5
  
  static IconSize := 24
  static IconVMargin := 5
  static IconHMargin := 10
  
  static CheckBoxHMargin := 10
  
  CreateContent()
  {
    global
    local currentX := this.PosX + this.BoxHMargin + this.BoxHPadding
    local currentY := this.BoxVMargin + this.BoxTopExtraPadding + this.BoxVPadding
    
    local maxWidth := 0
    local cellWidth
    
    ; program column
    For index, program in this.Programs
    {
      ; icon
      Gui, Add, Picture
        , % "h" . this.IconSize . " w-1"
        . " x" . currentX + this.IconHMargin
        . " y" . currentY + this.IconVMargin
        . " v" . program.IconVariable
        . " Hidden"
        , % program.icon
      
      ; checkbox
      Gui, Add, CheckBox
        , % "x" . currentX + this.IconHMargin * 2 + this.IconSize
        . " y" . currentY
        . " v" . program.CheckBoxVariable
        . " Checked"
        . " Hidden"
        , % program.Name
        
      GuiControlGet, result, Pos, % program.CheckBoxVariable
      
      ;align middle vertically
      GuiControl, Move, % program.CheckBoxVariable
        , % " y" . currentY + (this.IconVMargin * 2 + this.IconSize - resultH) / 2
      
      cellWidth := (this.IconHMargin + this.CheckBoxHMargin) * 2 + this.IconSize + resultW
      if (cellWidth >= maxWidth)
      {
        maxWidth := cellWidth
      }
      
      currentY += this.IconVMargin * 2 + this.IconSize
    }
    
    ;buttons collum
    currentX := this.PosX + this.BoxHMargin + this.BoxHPadding + maxWidth
    currentY := this.BoxVMargin + this.BoxTopExtraPadding + this.BoxVPadding
    For index, button in this.ChangeThemeButtons
    {
      Gui, Add, Button
        , % "x" . currentX + this.ButtonHMargin
        . " y" . currentY + this.ButtonVMargin
        . " w" . this.ButtonWidth
        . " h" . this.ButtonHeight
        . " g" . button.FunctionH
        . " v" . button.Variable
        . " Hidden"
        , % button.Label
      
      currentY += this.ButtonVMargin * 2 + this.ButtonHeight
    }
    
    this.OwnWidth := (currentX  + this.BoxHMargin + this.BoxHPadding
      + this.ButtonHMargin + this.ButtonWidth) - this.PosX
    this.OwnHeight := currentY + this.BoxVPadding + this.BoxVMargin
  }
  
  Activate()
  {
    ActionPannel.Width := this.OwnWidth
    ActionPannel.Height := this.OwnHeight
    
    ; program column
    For index, program in this.Programs
    {
      GuiControl, Show, % program.IconVariable
      GuiControl, Show, % program.CheckBoxVariable
    }    
    ;buttons collum
    For index, button in this.ChangeThemeButtons
    {
      GuiControl, Show, % button.Variable
    }
    
    this.ActivateBox()
  }
  Deactivate()
  {
    ; program column
    For index, program in this.Programs
    {
      GuiControl, Hide, % program.IconVariable
      GuiControl, Hide, % program.CheckBoxVariable
    }    
    ;buttons collum
    For index, button in this.ChangeThemeButtons
    {
      GuiControl, Hide, % button.Variable
    }
  }
}

class UselessButtonPannelClass extends ActionPannel
{
  OwnWidth := 0
  OwnHeight := 0
  
  static ButtonWidth := 120
  static ButtonHeight := 30
  
  static ButtonVMargin := 10
  static ButtonHMargin := 10
  
  static TextVMargin := 10
  static TextHMargin := 10
  
  NumPressed := 0
  
  CreateContent()
  {
    global
    
    Gui, Add, Button
      , % " x" . this.PosX + this.BoxHMargin + this.BoxHPadding + this.ButtonHMargin
      . " y" . this.BoxVMargin + this.BoxTopExtraPadding + this.BoxVPadding + this.ButtonVMargin
      . " w" . this.ButtonWidth
      . " h" . this.ButtonHeight
      . " vUselessButtonPannel_BtnUselessButton"
      . " gUselessButtonPannel_UselessButtonH"
      . " Hidden"
      , Useless Button
    
    Gui, Add, Text
      , % "x" . this.PosX + this.BoxHMargin + this.BoxHPadding + this.TextHMargin
      . " y" . this.PosY + this.BoxVMargin + this.BoxVPadding + this.BoxTopExtraPadding
        + this.ButtonVMargin * 2 + this.ButtonHeight + this.TextVMargin
      . " r2"
      . " center"
      . " vUselessButtonPannel_PressedTxt"
      . " Hidden"
      , % "You pressed this button    0 times"
    
    GuiControlGet, result, Pos, UselessButtonPannel_PressedTxt
    
    this.OwnWidth := this.BoxHMargin * 2 + resultW + this.BoxHPadding * 2 + this.ButtonHMargin * 2
    this.OwnHeight := (this.BoxVMargin  + this.BoxVPadding + this.TextVMargin + this.ButtonVMargin)
      *2 + this.BoxTopExtraPadding + this.ButtonHeight + resultH
    
    GuiControl, Move, UselessButtonPannel_BtnUselessButton
      , % "x" . this.PosX + (this.OwnWidth - this.ButtonWidth) / 2
    
    GuiControl, , UselessButtonPannel_PressedTxt
      , % "You have better things to do than to press this button"
  }
  
  IncrementNumPressed()
  {
    this.NumPressed ++
    text := "You pressed this button " . this.NumPressed . " times"
    text := "You have done at least " . this.NumPressed . " useless things today"
    
    if (this.NumPressed == 1)
    {
      text := "Ok, you were curious"
    }
    GuiControl, , UselessButtonPannel_PressedTxt
      , % text
    
    if (this.NumPressed > 1)
    {
      GuiControl, disable, UselessButtonPannel_BtnUselessButton
      MainPannel.SelectAction(0)
    }
  }
  
  Activate()
  {
    ActionPannel.Width := this.OwnWidth
    ActionPannel.Height := this.OwnHeight
    
    GuiControl, Enable, UselessButtonPannel_BtnUselessButton
    GuiControl, Show, UselessButtonPannel_BtnUselessButton
    GuiControl, Show, UselessButtonPannel_PressedTxt
    
    this.ActivateBox()
  }
  Deactivate()
  {
    GuiControl, Hide, UselessButtonPannel_BtnUselessButton
    GuiControl, Hide, UselessButtonPannel_PressedTxt
  }
}


class MiscActionsPannelClass extends ActionPannel
{
  OwnWidth := 0
  OwnHeight := 0
  
  static MiscActionsButtons := [new Button(1, "Change Folders Type", "MiscActionsChangeFolderTypeH", "BtnMiscActionsChangeFolderType")]
  
  static ButtonWidth := 120
  static ButtonHeight := 30

  static ButtonVMargin := 5
  static ButtonHMargin := 5
  
  CreateContent()
  {
    global
    local currentX := this.PosX + this.BoxHMargin + this.BoxHPadding
    local currentY := this.BoxVMargin + this.BoxTopExtraPadding + this.BoxVPadding
    
    For index, button in this.MiscActionsButtons
    {
      Gui, Add, Button
        , % "x" . currentX + this.ButtonHMargin
        . " y" . currentY + this.ButtonVMargin
        . " w" . this.ButtonWidth
        . " h" . this.ButtonHeight
        . " g" . button.FunctionH
        . " v" . button.Variable
        . " Hidden"
        , % button.Label
      
      currentY += this.ButtonVMargin * 2 + this.ButtonHeight
    }
    
    this.OwnWidth := (currentX  + this.BoxHMargin + this.BoxHPadding
      + this.ButtonHMargin + this.ButtonWidth) - this.PosX
    this.OwnHeight := currentY + this.BoxVPadding + this.BoxVMargin
  }
  
  Activate()
  {
    ActionPannel.Width := this.OwnWidth
    ActionPannel.Height := this.OwnHeight
    
    For index, button in this.MiscActionsButtons
    {
      GuiControl, Show, % button.Variable
    }
    
    this.ActivateBox()
  }
  Deactivate()
  {
    For index, button in this.MiscActionsButtons
    {
      GuiControl, Hide, % button.Variable
    }
  }
}

Goto, EndOfThisScript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; handler functions

GetChangeThemeProgramsChecked()
{
  CheckedPrograms := Object()
  For index, program in ChangeThemePannel.Programs
  {
    GuiControlGet, result, ,% program.CheckBoxVariable
    
    if (result == 1)
    {
      CheckedPrograms.Insert(program.VariableBaseName)
    }
  }
  return CheckedPrograms
}

return
;main pannel handlers
OpenFH:
{
  MainPannel.SelectAction(1)
  return
}

OpenPH:
{
  MainPannel.SelectAction(2)
  return
}

ChangeThemeH:
{
  MainPannel.SelectAction(3)
  return
}
MiscActionsH:
{
  MainPannel.SelectAction(4)
  return
}
UselessButtonH:
{
  MainPannel.SelectAction(5)
  return
}

; change theme handlers
ChangeThemeRedH:
{
  CheckedPrograms := GetChangeThemeProgramsChecked()
  ChangeTheme("Red", CheckedPrograms)
  return
}

ChangeThemeGreenH:
{
  CheckedPrograms := GetChangeThemeProgramsChecked()
  ChangeTheme("Green", CheckedPrograms)
  return
}

ChangeThemeBlueH:
{
  CheckedPrograms := GetChangeThemeProgramsChecked()
  ChangeTheme("Blue", CheckedPrograms)
  return
}

ChangeThemeOrangeH:
{
  CheckedPrograms := GetChangeThemeProgramsChecked()
  ChangeTheme("Orange", CheckedPrograms)
  return
}

ChangeThemeBlackH:
{
  CheckedPrograms := GetChangeThemeProgramsChecked()
  ChangeTheme("Black", CheckedPrograms)
  return
}

; misc actions pannel handlers
MiscActionsChangeFolderTypeH:
{
  ChangeFolderTypeDialog()
  return
}

; useless button pannel handlers
UselessButtonPannel_UselessButtonH:
{
  UselessButtonPannel.IncrementNumPressed()
  return
}

; something something

AnimationStepLabel:
{
  Animation.DoStep()  
  return
}

;-- ease functions ----
EaseInOutQuad(time, v0, deltaV, duration)
{
  time /= duration / 2
  if (time < 1)
    return deltaV / 2 * time * time + v0
  time -= 1
  return -deltaV / 2 * (time * (time - 2) - 1) + v0
}

EaseInOutCubic(time, v0, deltaV, duration)
{
  time /= duration / 2
  if (time < 1)
    return deltaV / 2 * time * time * time + v0
  time -= 2
  return deltaV / 2 * (time * time * time + 2) + v0
}
EndOfThisScript:
