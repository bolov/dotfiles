global ProgramFunctions := {"Windows" : Func("ChangeThemeInWindows")
	, "Winamp" : Func("ChangeThemeInWinamp")
	, "MiniLyrics" : Func("ChangeThemeInMinilyrics")
	, "ObjectDock" : Func("ChangeThemeInObjectDock")}


ChangeTheme(Theme, Programs)
{
  static MouseSpeed := 2
  static ActionDelay := 500
  
  ;BlockInput, Mouse
  
  ;save mouse postion
  CoordMode, Mouse, Screen
  MouseGetPos, MouseX, MouseY
  CoordMode, Mouse, Relative
  
  For index, program in Programs
  {
    ProgramFunctions[program].(Theme, MouseSpeed, ActionDelay)
  }
  
  ;restore mouse postion
  CoordMode, Mouse, Screen
  MouseMove, % MouseX, % MouseY, % MouseSpeed
  CoordMode, Mouse, Relative
  
  ;BlockInput, Default
  
}

ChangeThemeInWindows(Theme, MouseSpeed, ActionDelay)
{
  static SavedThemes := ["black", "bloody red", "blue", "blue lighter", "green", "orange", "red"]
  static ThemePannel := {X : 242, Y : 171, ButtonWidth : 136, ButtonHeight : 124}
  
  static OpenCommand := "control desktop"
  static WndName := "Personalization"
  static WndClass := "ahk_class CabinetWClass"
  static CommandWaitInterval := 100
  static CommandWaitRetryTime := 2000
  static CommandWaitRetries := CommandWaitRetryTime / CommandWaitInterval
  
  ; open control pannel destop personalization
  IfWinNotExist, % WndName . " " . WndClass
  {
    run % OpenCommand
  }
  
  ; wait if necessary to initialize and then activate it and maximize it
  Loop, % CommandWaitRetries
  {
    IfWinExist, % WndName . " " . WndClass
    {
      break
    }
    Sleep, % CommandWaitInterval
  }
  IfWinNotExist, % WndName . " " . WndClass
  {
    MsgBox, % "Control Pannel doesn't seem to open"
    return
  }
  
  WinActivate, % WndName . " " . WndClass
  WinMaximize, % WndName . " " . WndClass
  
  SleepIf(ActionDelay)
  
  ;press the button
  For index, savedTheme in SavedThemes
  {
    if (SavedTheme = Theme)
    {
      MouseClick
        , left
        , % ThemePannel.X + ThemePannel.ButtonWidth * (index - 1) + ThemePannel.ButtonWidth / 2
        , % ThemePannel.Y + ThemePannel.ButtonHeight / 2
        ,
        , % MouseSpeed
    }
  }
  
  SleepIf(ActionDelay)
  WinClose, A
}

ChangeThemeInWinamp(Theme, MouseSpeed, ActionDelay)
{
  static Skins := [{skin : "Royal Black", index : 55}
    , {skin : "Total Black | Blue", index : 64}
    , {skin : "Total Black | Green", index : 65}
    , {skin : "Total Black | Red", index : 67}
    , {skin : "Total Black | Yellow", index : 68}]
  static ThemesToSkins := [{theme : "Red", skin : "Total Black | Red"}
    , {theme : "Green", skin : "Total Black | Green"}
    , {theme : "Blue", skin : "Total Black | Blue"}
    , {theme : "Orange", skin : "Total Black | Yellow"}
    , {theme : "Black", skin : "Royal Black"}]
  
  static PageDwnNoLines := 4
  
  static WndClass := "ahk_class BaseWindow_RootWnd"
  static ChangeArea := {PopupX : 710, PopupY : 105
    , ToSkinOffsetX : 50, ToSkinOffsetY : -35
    , ToInfoOffsetX : 50, ToInfoOffsetY : -125
    , ActivateX : 550, ActivateY : 50}
  
  IfWinNotExist, % WndClass
  {
    MsgBox, % "Winamp is not running or it't minimized"
  }
  WinActivate, % WndClass
  
  ; change area to skin
  SleepIf(ActionDelay)
  MouseClick
    , left
    , % ChangeArea.PopupX
    , % ChangeArea.PopupY
    , , % MouseSpeed
  SleepIf(ActionDelay)
  MouseClick
    , left
    , % ChangeArea.ToSkinOffsetX
    , % ChangeArea.ToSkinOffsetY
    , , MouseSpeed
    , , R
  SleepIf(ActionDelay)
  MouseClick
    , left
    , % ChangeArea.ActivateX
    , % ChangeArea.ActivateY
    , , MouseSpeed
  
  send {Home}
  
  ; get the position of the desired skin
  For i, elem in ThemesToSkins
  {
    if (elem.theme = Theme)
    {
      skin := elem.skin
      break
    }
  }
  For i, elem in Skins
  {
    if (elem.skin = skin)
    {
      index := elem.index
    }
  }
  
  ; navigate to desired skin and select it
  Loop, % (index - 1) // 4
  {
    Send {PGDN}
  }
  Loop, % mod(index - 1, 4)
  {
    Send {DOWN}
  }
  SleepIf(ActionDelay)
  Send {ENTER}
  
  ; w8 a little longer for the skin to apply
  SleepIf(4 * ActionDelay)
  
  ; change area to file info
  MouseClick
    , left
    , % ChangeArea.PopupX
    , % ChangeArea.PopupY
    , , % MouseSpeed
  SleepIf(ActionDelay)
  MouseClick
    , left
    , % ChangeArea.ToInfoOffsetX
    , % ChangeArea.ToInfoOffsetY
    , , MouseSpeed
    , , R
}
ChangeThemeInMinilyrics(Theme, MouseSpeed, ActionDelay)
{
  static Skins := [{skin : "black", index : 1}
    , {skin : "blue lighter", index : 2}
    , {skin : "green", index : 3}
    , {skin : "green - desaturated", index : 4}
    , {skin : "orange - portal", index : 5}
    , {skin : "red", index : 6}]
  static ThemesToSkins := [{theme : "Red", skin : "red"}
    , {theme : "Green", skin : "green - desaturated"}
    , {theme : "Blue", skin : "blue lighter"}
    , {theme : "Orange", skin : "orange - portal"}
    , {theme : "Black", skin : "black"}]
  
  static Floating := {PopupX : 100, PopupY : 300
    , PreferencesX : 100, PreferencesY : -200}
  
  static Preferences := {ThemesX : 170, ThemesY : 60
    , SavedThemesX : 70, SavedThemesY1 : 160, SavedThemesHeight : ((335 - 155) / 10) }
  
  static WndClass := "ahk_class MiniLyrics"
  static WndPrefClass := "ahk_class CMPSkin"
  static WndPrefName := "Preferences"
  
  static PrefAnimTime := 500
  
  static CommandWaitInterval := 100
  static CommandWaitRetryTime := 2000
  static CommandWaitRetries := CommandWaitRetryTime / CommandWaitInterval
  
  IfWinNotExist, % WndClass
  {
    MsgBox, % "MiniLyrics is not running or it's minimized"
  }
  
  SleepIf(ActionDelay)
  WinActivate, % WndClass
  MouseClick, Right
    , % Floating.PopupX
    , % Floating.PopupY
    , , % MouseSpeed
  SleepIf(ActionDelay)
  MouseClick
    , left
    , % Floating.PreferencesX
    , % Floating.PreferencesY
    , , MouseSpeed
    , , R
  
  Loop, % CommandWaitRetries
  {
    IfWinExist, % WndPrefName . " " . WndPrefClass
    {
      break
    }
    Sleep, % CommandWaitInterval
  }
  IfWinNotExist, % WndPrefName . " " . WndPrefClass
  {
    MsgBox, % "MiniLyrics preferences window doesn't seem to open"
    return
  }
  
  SleepIf(ActionDelay)
  WinActivate, % WndPrefName . " " . WndPrefClass
  MouseClick
    , left
    , % Preferences.ThemesX
    , % Preferences.ThemesY
    , , % MouseSpeed
  
  ; get the position of the desired skin
  For i, elem in ThemesToSkins
  {
    if (elem.theme = Theme)
    {
      skin := elem.skin
      break
    }
  }
  For i, elem in Skins
  {
    if (elem.skin = skin)
    {
      index := elem.index
    }
  }
  
  SleepIf(ActionDelay)
  
  ;wait for animation
  Sleep, % PrefAnimTime - ActionDelay
  
  WinActivate, % WndPrefName . " " . WndPrefClass
  MouseClick
    , left
    , % Preferences.SavedThemesX
    , % Preferences.SavedThemesY1 + Preferences.SavedThemesHeight / 2
      + (index - 1 ) * Preferences.SavedThemesHeight
    , , MouseSpeed
  
  ; shortcut for load theme
  SleepIf(ActionDelay)
  Send, !l
  
  ; close the window
  SleepIf(ActionDelay)
  WinActivate, % WndPrefName . " " . WndPrefClass
  Send, !{F4}
}

class RGBColor
{
  __New(Red, Green, Blue)
  {
    this.Red := Red
    this.Green := Green
    this.Blue := Blue
  }
}

ChangeThemeInObjectDock(Theme, MouseSpeed, ActionDelay)
{
  static command := "C:\Program Files (x86)\Stardock ObjectDock\ObjectDock.exe"
  
  static ThemeColors := Object()
  
  ColorArray := Object()
  ColorArray.Insert(new RGBColor(255, 0, 0))
  ColorArray.Insert(new RGBColor(255, 0, 0))
  ColorArray.Insert(new RGBColor(255, 0, 0))
  ColorArray.Insert(new RGBColor(255, 0, 0))
  ThemeColors.Insert({Theme : "Red", Colors : ColorArray})
  
  ColorArray := Object()
  ColorArray.Insert(new RGBColor(0, 255, 0))
  ColorArray.Insert(new RGBColor(0, 255, 0))
  ColorArray.Insert(new RGBColor(0, 255, 0))
  ColorArray.Insert(new RGBColor(0, 255, 0))
  ThemeColors.Insert({Theme : "Green", Colors : ColorArray})
  
  ColorArray := Object()
  ColorArray.Insert(new RGBColor(170, 200, 255))
  ColorArray.Insert(new RGBColor(170, 200, 255))
  ColorArray.Insert(new RGBColor(170, 200, 255))
  ColorArray.Insert(new RGBColor(170, 200, 255))
  ThemeColors.Insert({Theme : "Blue", Colors : ColorArray}) ColorArray := Object()
  
  ColorArray := Object()
  ColorArray.Insert(new RGBColor(255, 130, 0))
  ColorArray.Insert(new RGBColor(255, 130, 0))
  ColorArray.Insert(new RGBColor(255, 130, 0))
  ColorArray.Insert(new RGBColor(255, 130, 0))
  ThemeColors.Insert({Theme : "Orange", Colors : ColorArray})
  
  ColorArray := Object()
  ColorArray.Insert(new RGBColor(50, 50, 50))
  ColorArray.Insert(new RGBColor(50, 50, 50))
  ColorArray.Insert(new RGBColor(50, 50, 50))
  ColorArray.Insert(new RGBColor(50, 50, 50))
  ThemeColors.Insert({Theme : "Black", Colors : ColorArray})
  
  ;MsgBox, % ThemeColors[1].Colors[1].Red
  ;return
  
  static WndMyDocs := "ObjectDock: My Docks... ahk_class #32770"
  static WndProperties := "ObjectDock Properties ahk_class #32770"
  static WndColor := "Color ahk_class #32770"
  
  static Bar := {X : 50, Y : 5}
  static DockList := {X : 50, Y1 : 100, Height : (190 - 100) / 4}
  static ColorChange := {X : 350, Y : 450}
  static RedColorInput := {X : 420, Y : 235}
  
  static CommandWaitInterval := 100
  static CommandWaitRetryTime := 2000
  static CommandWaitRetries := CommandWaitRetryTime / CommandWaitInterval
  
  ;open my docs
  run % command
  
  WaitUntilWindowExist(WndMyDocs, CommandWaitRetries, CommandWaitInterval)
  IfWinNotExist, % WndMyDocs
  {
    MsgBox, % "Object Dock My Docs window doesn't seem to open"
    return
  }
  SleepIf(ActionDelay)
  WinActivate, % WndMyDocs
  MouseClick
    , left
    , % Bar.X
    , % Bar.Y
    , , % MouseSpeed
  
  For i, elem in ThemeColors
  {
    if (elem.Theme = Theme)
    {
      ThemeColorsIdx := i
      break
    }
  }
  
  ;MsgBox, % ThemeColors[ThemeColorsIdx].Colors[1].Red
  ;return
  
  ;for each dock
  Loop, 4
  {
    ;open properties
    WinActivate, % WndMyDocs
    MouseClick
      , left
      , % DockList.X
      , % DockList.Y1 + DockList.Height / 2 + (A_Index - 1) * DockList.Height
      , , MouseSpeed
    MouseClick, left
    
    WaitUntilWindowExist(WndProperties, CommandWaitRetries, CommandWaitInterval)
    IfWinNotExist, % WndProperties
    {
      MsgBox, % "ObjectDock Properties doesn't seem to open"
      break
    }
    
    SleepIf(ActionDelay)
    WinActivate, % WndProperties
    MouseClick
      , left
      , % Bar.X
      , % Bar.Y
      , , % MouseSpeed
    
    ;open color dialog
    SleepIf(ActionDelay)
    WinActivate, % WndProperties
    MouseClick
      , left
      , % ColorChange.X
      , % ColorChange.Y
      , , MouseSpeed
    
    WaitUntilWindowExist(WndColor, CommandWaitRetries, CommandWaitInterval)
    IfWinNotExist, % WndColor
    {
      MsgBox, % "ObjectDock Color window doesn't seem to open"
      break
    }
    
    ;change color
    ;red
    SleepIf(ActionDelay)
    WinActivate, % WndColor
    MouseClick
      , left
      , % RedColorInput.X
      , % RedColorInput.Y
      , , % MouseSpeed
    send ^a
    send, % ThemeColors[ThemeColorsIdx].Colors[A_Index].Red
    
    ; green
    SleepIf(ActionDelay)
    WinActivate, % WndColor
    send {Tab}
    send, % ThemeColors[ThemeColorsIdx].Colors[A_Index].Green
    
    ; blue
    SleepIf(ActionDelay)
    WinActivate, % WndColor
    send {Tab}
    send, % ThemeColors[ThemeColorsIdx].Colors[A_Index].Blue
    
    ;close color dialog
    SleepIf(ActionDelay)
    send {ENTER}
    
    ;close properties
    SleepIf(ActionDelay)
    WinClose, % WndProperties
  }
  ;close my docks
  SleepIf(ActionDelay)
  WinClose, % WndMyDocs
  
}