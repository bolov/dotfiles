; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

;#z::Run www.autohotkey.com

;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return

#SingleInstance Force

#include G:\epic_fail_recovery\scripts\autohotkey
;SetWorkingDir, % A_ScriptDir

#Include Quick Action.ahk


SetTitleMatchMode 2

GroupAdd, Explorer, ahk_class CabinetWClass ; normal explorer window
GroupAdd, Explorer, ahk_class #32770 ; save as/open/etc dialog box

Groupadd, Games, ahk_class RiotWindowClass  ; League of Legends
Groupadd, Games, ahk_class UT2004UnrealWWindowsViewportWindow  ; UT2004
GroupAdd, Games, ahk_class LaunchUnrealUWindowsClient
GroupAdd, Games, ahk_class IW5 ; CoD Modern Warfare 3
GroupAdd, Games, ahk_class Valve001 ; Half Life 2
GroupAdd, Games, ahk_class CryENGINE ; Prey
GroupAdd, Games, ahk_class RE_BHD ; Resident Evil HD Remastered
GroupAdd, Games, ahk_class SpinTiresWindowClass ; SpinTires
GroupAdd, Games, ahk_class BioshockUnrealWWindowsViewportWindow ; BioShock Remastered
GroupAdd, Games, ahk_class _uengine_ ; Metro Last Light Redux
GroupAdd, Games, ahk_class Respawn001 ; Apex Legends


#IfWinActive ahk_class RE_BHD ; Resident Evil HD Remastered
	XButton1::m
#IfWinActive

#IfWinActive ahk_class SpinTiresWindowClass ; Resident Evil HD Remastered
	XButton1::f
#IfWinActive



MainFrame.Create()

#XButton1::MainFrame.Show()


GuiClose:
  MainFrame.Hide()
  return

;; - characters

;; - shortcuts:

;;^!t::Run C:\cygwin\bin\mintty, C:\cygwin\home\pk

;;---------- mouse no modifier --------------

AppsKey::alt

;; ^!c::SoundSet, +10
  
WheelLeft::send {Volume_Down}
WheelRight::send {Volume_Up} 

#WheelUp::Volume_Up
#WheelDown::Volume_Down
#MButton::send {Media_Play_Pause}

;;---------- wheel not working
  
;;WheelDown::return
;;WheelUp::return

;;^+Up::send {WheelUp}
;;^+Down::send {WheelDown}

#IfWinNotActive ahk_group Games
	#m::Run, wsl-start-x-app.exe "gnome-terminal --working-directory=~"
	#n::Run, chrome
	
	^#l::^#right
	^#h::^#left
	
#IfWinActive

#IfWinNotActive ahk_group Games
  ^XButton2::send {WheelUp} ; minilyrics global open lyrics
  ^XButton1::send {WheelDown} ; minilyrics global bring to front/hide
#IfWinActive


GoMouseGo(x, y, speed, w8)
{
	MouseMove, x, y, speed
	MouseClick
	Sleep, w8
}

cancel_lol_token := false

cancel_lol_action()
{
	global cancel_lol_token := true
}

LolAddBot(y, speed, w8, long_w8, champ_num_scrolls, champ_y)
{
	rx := 1150 ; right x
	lx := 900  ; left x
	
	GoMouseGo(rx, y, speed, long_w8) ; Add Bot
	if %cancel_lol_token%
		return
	
	GoMouseGo(lx, y, speed, w8) ; Champion Drowpdown
	if %cancel_lol_token%
		return
	
	; scroll to top
	MouseMove, lx, y + 40, speed
	MouseClick, WheelUp, , , 22  ;
	Sleep, w8
	if %cancel_lol_token%
		return
	
	; scroll and select champion
	MouseClick, WheelDown, , , champ_num_scrolls
	Sleep, w8
	GoMouseGo(lx, y + champ_y, speed, long_w8)
	if %cancel_lol_token%
		return
	
	GoMouseGo(rx, y, speed, w8) ; Difficulty Dropdown
	if %cancel_lol_token%
		return
	GoMouseGo(rx, y + 80, speed, long_w8) ; Intermediate
	if %cancel_lol_token%
		return
}

Lol_1v5()
{
	sp := 5
	w8 := 1000
	long_w8 = 3000
	
	global cancel_lol_token := false
	
	GoMouseGo(140, 50, sp, long_w8) ;; Play
	if %cancel_lol_token%
		return
	
	GoMouseGo( 500, 120, sp, w8) ;; Create Custom
	if %cancel_lol_token%
		return
	GoMouseGo( 200, 770, sp, w8) ;; Password
	if %cancel_lol_token%
		return
	Send, asd
	if %cancel_lol_token%
		return
	GoMouseGo(680, 850, sp, long_w8 * 1.5)  ;; Confirm
	if %cancel_lol_token%
		return
	
	 ;; Add bot
	LolAddBot(300, sp, w8, long_w8, 22, 180) ;; Add Zyra
	if %cancel_lol_token%
		return
	LolAddBot(360, sp, w8, long_w8, 2, 100) ;; Add Brand
	if %cancel_lol_token%
		return
	LolAddBot(420, sp, w8, long_w8, 2, 100) ;; Add Cait
	if %cancel_lol_token%
		return
	LolAddBot(480, sp, w8, long_w8, 2, 100) ;; Add Cass
	if %cancel_lol_token%
		return
	LolAddBot(540, sp, w8, long_w8, 9, 120) ;; Add Mal
	if %cancel_lol_token%
		return
	
}

#IfWinActive ahk_class RCLIENT
	Esc::cancel_lol_action()
	^RBUTTON::Lol_1v5()
#IfWinActive 


;;#IfWinActive

#IfWinActive ahk_class BaseWindow_RootWnd ; winamp
; show milkdrop and position it under the taskbar
  XButton1::
    CoordMode, Mouse, Screen  ; set coord to screen (as oposed to window)
    
    IfWinNoTExist, ahk_class MilkDrop2
    {
      send, ^+k ; CTRL SHIFT K
      
      ; check until it is created (100 ms first, then for 10s in 500ms increment)
      Sleep, 100
      loop, 20
      {
        IfWinExist, ahk_class MilkDrop2
        {
          break
        }
        Sleep 500
      }
    }
    
    ; check if it's minimized
    WinGet, window_state, MinMax, ahk_class MilkDrop2
    if (window_state = -1)
    {
      WinRestore, ahk_class MilkDrop2
    }
    
    ;dual monitor setup, right monitor
    ;WinMove, ahk_class MilkDrop2, , 1913, 0, 304, 1080
    
    ;dual monitor setup, left monitor
    WinMove, ahk_class MilkDrop2, , 1670, 0, 258, 1086
    
    ;dual monitor setup, both monitors
    ;WinMove, ahk_class MilkDrop2, , 1670, 0, 516, 1086
    
    ;single minitor setup
    ;WinMove, ahk_class MilkDrop2, , -7, 0, 182, 1086
    
    ;single minitor setup, desktop mode, all destoktop
    ;WinMove, ahk_class MilkDrop2, , 0, 0, 1920, 1080
    
    ;send to background
    WinSet, Bottom, , ahk_class MilkDrop2
    
    return

#IfWinNotActive ahk_group Games
  XButton1::#e
#IfWinActive ahk_class BaseWindow_RootWnd ; winamp
  XButton2::send, {CTRL down}{ALT down}{SHIFT down}nullsoft{SHIFT up}{CTRL up}{ALT up}{SHIFT up}
#IfWinActive ahk_group Explorer
  XButton2::!Up
#IfWinActive

;; control ^
;; alt     !
;; shift   +
;; win     #

;; Game Controller

; #IfWinNotActive ahk_group Games
	; Joy1::run "C:\Program Files (x86)\Steam\Steam.exe" "steam://open/bigpicture" ; Triangle
	; ;Joy2::Send {Enter}
	; ;Joy3::Send {Esc}
	; Joy4::Send {LWin} ; Square
	
	; Joy6::Send #`t ; R1
; #IfWinActive


;;  media controls

;; ^WheelLeft::send {Media_Prev}
;; ^WheelRight::send {Media_Next}
;; ^!WheelUp::send {Media_Prev}
;; ^!WheelDown::send {Media_Next}

;; ^XButton2::send {Media_Play_Pause}
;; ^XButton1::send {Media_Stop}

;; ^+Up::send {Volume_Up}
;; ^+Down::send {Volume_Down}}

^+WheelUp::send {Volume_Up}
^+WheelDown::send {Volume_Down}}

^Volume_Down::send {Media_Prev}
^Volume_Up::send {Media_Next}


;; minilyrics

#IfWinNotActive ahk_group Games
  !XButton2::send ^!{Numpad8} ; minilyrics global open lyrics
  !XButton1::send ^!{Numpad2} ; minilyrics global bring to front/hide
#IfWinActive

;; turn off displays

^+s::Run %ProgramData%\Microsoft\Windows\Start Menu\Programs\Screen Off\Screen Off.lnk

;; explorer path

#IfWinActive ahk_group Explorer ; explorer
  +WheelLeft::send !d^{c}{Esc} ; copy path
  +WheelRight::send !d^{v}{Enter} ; paste and go to path
#IfWinActive

;; switch focus to VM Guest
#IfWinExist ahk_class VMUIFrame ;VMware workstation
  !SC029::SwToVMGuest() ;grave accent (tilde key)
#IfWinExist

;; switch focus to VM Guest
SwToVMGuest()
{
  WinActivate, ahk_class VMUIFrame ; Activate VMware workstation
  sleep, 100
  send ^g
}


;;--------- visual studio insert comment ----------
#IfWinActive Microsoft Visual Studio (Administrator)
  ^8::send /*  */{Left}{Left}{Left}
#IfWinActive
;;-------- window arrange------------


#Numpad1::PositionWindow("A", 1)
#Numpad2::PositionWindow("A", 2)
#Numpad3::PositionWindow("A", 3)
#Numpad4::PositionWindow("A", 4)
#Numpad5::PositionWindow("A", 5)
#Numpad6::PositionWindow("A", 6)
#Numpad7::PositionWindow("A", 7)
#Numpad8::PositionWindow("A", 8)
#Numpad9::PositionWindow("A", 9)

; positions:
; quad:               dual horizontally:        triple vertically
;
; +---+---+           +-------+                 +---+---+---+
; | 7 | 9 |           |   8   |                 |   |   |   |
; +---+---+           +---+---+                 | 4 | 5 | 6 |
; | 1 | 3 |           |   2   |                 |   |   |   |
; +---+---+           +-------+                 +---+---+---+


PositionWindow(WinTitle, Position)
{
  WinRestore, %WinTitle%
  WinGetPos, windowX, windowY, windowW, windowH, %WinTitle%
  monitorNo := GetWindowMonitor(windowX, windowY, windowW, windowH)
  GetPositionCoord(monitorNo, Position, newX, newY, newW, newH)
  ;MsgBox, %monitorNo% %Position% %newX% %newY% %newW% %newH%
  WinMove, %WinTitle%, , newX, newY, newW, newH
}

; assumes that the monitors are arranged horizontally from left to right
GetWindowMonitor(windowX, windowY, windowW, windowH)
{
  centerX := windowX + windowW / 2
  SysGet, monitorCount, MonitorCount
  
  Loop, %monitorCount%
  {
    SysGet, mon, Monitor, %a_index%
    if (centerX < monRight)
      return %a_index%
  }
}

GetPositionCoord(MonitorNo, Position, ByRef newX, ByRef newY, ByRef newW, ByRef newH)
{
  SysGet, mon, MonitorWorkArea, %MonitorNo%
  
  if (Position = 7 || Position = 9 || Position = 1 || Position = 3)
    newW := (monRight - monLeft) / 2
  if (Position = 8 || Position = 2)
    newW := monRight - monLeft
  if (Position = 4 || Position = 5 || Position = 6)
    newW := (monRight - monLeft) / 3
  
  if (Position = 7 || Position = 9 || Position = 1 || Position = 3 || Position = 8 || Position = 2)
    newH := (monBottom - monTop) / 2
  if (Position = 4 || Position = 5 || Position = 6)
    newH := monBottom - monTop
  
  if (Position = 7 || Position = 1 || Position = 8 || Position = 2 || Position = 4)
    newX := monLeft
  if (Position = 9 || Position = 3)
    newX := (monLeft + monRight) / 2
  if (Position = 5)
    newX := (2 * monLeft + monRight) / 3
  if (Position = 6)
    newX := (monLeft + 2 * monRight) / 3
  
  if (Position = 7 || Position = 9 || Position = 8 || Position = 4 || Position = 5 || Position = 6)
    newY := monTop
  if (Position = 1 || Position = 3 || Position = 2)
    newY := (monTop + monBottom) / 2
}


; open programs

#t::OpenTerminal()

OpenTerminal()
{
  IfWinNotActive, ahk_class CabinetWClass
  {
    Run "C:\cygwin\bin\mintty.exe" -i /Cygwin-Terminal.ico -
    return
  }
 
  ControlGetText, path, ToolbarWindow322, A
  ; path is retrieved as "address: E:\pk\Programe și Proiecte"
  path := SubStr(path, 10)
  
  ; sometimes the address is "Computer" or "Desktop" or smth
  ; so we take only the ones starting with drive letter followed by colon
  if (SubStr SubStr(path, 2, 1) = ":")
  {
    Run "C:\cygwin\bin\mintty.exe" -i /Cygwin-Terminal.ico, %path%
  } else
  {
    Run "C:\cygwin\bin\mintty.exe" -i /Cygwin-Terminal.ico -
  }
 
  
  return
}




; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
