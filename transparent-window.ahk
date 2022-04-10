;Global variable
ToolTipText = Text

; Press alt-d. Minimizes all windows
!d::  
    WinMinimizeAll
return

; Press alt-m. Unminimizes all windows
!m::  
    WinMinimizeAllUndo
return

; Press alt-t. Set window semi-transparent
!t::  
    DetectHiddenWindows, on
    WinGet, curtrans, Transparent, A
    if curtrans = 125
    {
    WinSet, Transparent, OFF, A
    WinSet, Transparent, 255, A
    ToolTipText = Set window opacity
    }
    else
    {
    WinSet, Transparent, 125, A
    ToolTipText = Set window semi-transparent
    }
    Gosub, ShowTransparencyToolTip
return

; Press alt-a. Makes a window stay on top of all other windows. 
!a::
    Winset, Alwaysontop, , A
return

; Press alt-x. Maximize active wiindow
!x::
    WinMaximize, A 
    ToolTipText = Maximize window 
    Gosub, ShowTransparencyToolTip
return

; Press alt-n. Minimize active wiindow
!n::
    WinMinimize, A 
    ToolTipText = Minimize window 
    Gosub, ShowTransparencyToolTip
return

; Press alt-q. Close active window
!q::
    ToolTipText = Close window 
    Gosub, ShowTransparencyToolTip
    Send !{F4}
return

; Press alt-j. Window shrinks to half screen size and snap top
!j::
  WinGetPos,X,Y,W,H,A,,,
  WinMaximize
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

  ; if this is greater than 1, we're on the secondary (right) monitor. This
  ;   means the center of the active window is a positive X coordinate
  if ( X + W/2 > 0 ) {
  SysGet, MonitorWorkArea, MonitorWorkArea, 1
  WinMove,A,,0,0 , A_ScreenWidth, (MonitorWorkAreaBottom/2)
  ;MsgBox 11
  }
  else {
  SysGet, MonitorWorkArea, MonitorWorkArea, 2
  WinMove,A,,0,0 , A_ScreenWidth, (MonitorWorkAreaBottom/2)
  ;MsgBox 22
  }
  ToolTipText = Window shrinks to half screen size and snap top
  Gosub, ShowTransparencyToolTip
return

; Press alt-k. Window shrinks to half screen size and snap down 
!k::
  WinGetPos,X,Y,W,H,A,,,
  WinMaximize
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

  ; if this is greater than 1, we're on the secondary (right) monitor. This
  ;   means the center of the active window is a positive X coordinate
  if ( X + W/2 > 0 ) {
  SysGet, MonitorWorkArea, MonitorWorkArea, 1
  WinMove,A,,0,MonitorWorkAreaBottom/2 , A_ScreenWidth, (MonitorWorkAreaBottom/2)
  }
  else {
  SysGet, MonitorWorkArea, MonitorWorkArea, 2
  WinMove,A,,0,MonitorWorkAreaBottom/2 , A_ScreenWidth, (MonitorWorkAreaBottom/2)
  }
  ToolTipText = Window shrinks to half screen size and snap down
  Gosub, ShowTransparencyToolTip
return

; Press alt-h. Window shrinks to half screen size and snap left 
!h::
  WinGetPos,X,Y,W,H,A,,,
  WinMaximize
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

  ; if this is greater than 1, we're on the secondary (right) monitor. This
  ;   means the center of the active window is a positive X coordinate
  if ( X + W/2 > 0 ) {
  SysGet, MonitorWorkArea, MonitorWorkArea, 1
  WinMove,A,,0,0 , (A_ScreenWidth/2), MonitorWorkAreaBottom
  }
  else {
  SysGet, MonitorWorkArea, MonitorWorkArea, 2
  WinMove,A,,0,0 , (A_ScreenWidth/2), MonitorWorkAreaBottom
  }
  ToolTipText = Window shrinks to half screen size and snap left
  Gosub, ShowTransparencyToolTip
return

; Press alt-l. Window shrinks to half screen size and snap right 
!l::
  WinGetPos,X,Y,W,H,A,,,
  WinMaximize
  WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,

  ; if this is greater than 1, we're on the secondary (right) monitor. This
  ;   means the center of the active window is a positive X coordinate
  if ( X + W/2 > 0 ) {
  SysGet, MonitorWorkArea, MonitorWorkArea, 1
  WinMove,A,,(A_ScreenWidth/2),0 , (A_ScreenWidth/2), MonitorWorkAreaBottom
  }
  else {
  SysGet, MonitorWorkArea, MonitorWorkArea, 2
  WinMove,A,,(A_ScreenWidth/2),0 , (A_ScreenWidth/2), MonitorWorkAreaBottom
  }
  ToolTipText = Window shrinks to half screen size and snap right
  Gosub, ShowTransparencyToolTip
return

; Press alt+<mouse wheel up> to Make active window gradually opacity,
!WheelUp::  ; Increments transparency up by 3.375% (with wrap-around)
    DetectHiddenWindows, on
    WinGet, curtrans, Transparent, A
    if ! curtrans
        curtrans = 255
    newtrans := curtrans + 8
    ToolTipText = Opacity :%curtrans%
    if newtrans > 0
    {
        WinSet, Transparent, %newtrans%, A
    }
    else
    {
        WinSet, Transparent, OFF, A
        WinSet, Transparent, 255, A
    }
    Gosub, ShowTransparencyToolTip
return

; Press alt+<mouse wheel down> to Make active window gradually transparent ,
!WheelDown::  ; Increments transparency down by 3.375% (with wrap-around)
    DetectHiddenWindows, on
    WinGet, curtrans, Transparent, A
    if ! curtrans
        curtrans = 255
    newtrans := curtrans - 8
    ToolTipText = Opacity :%curtrans%
    if newtrans > 0
    {
        WinSet, Transparent, %newtrans%, A
    }
    ;else
    ;{
    ;    WinSet, Transparent, 255, A
    ;    WinSet, Transparent, OFF, A
    ;}
    Gosub, ShowTransparencyToolTip
return

; Press alt-<mouse right click> to drag active window
!RButton::
        CoordMode, Mouse  ; Switch to screen/absolute coordinates.
        MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
        WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
        WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
        if EWD_WinState = 0  ; Only if the window isn't maximized 
            SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
        return

        EWD_WatchMouse:
        GetKeyState, EWD_RButtonState, RButton, P
        if EWD_RButtonState = U  ; Button has been released, so drag is complete.
        {
            SetTimer, EWD_WatchMouse, off
            return
        }
        GetKeyState, EWD_EscapeState, Escape, P
        if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
        {
            SetTimer, EWD_WatchMouse, off
            WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
            return
        }
        ; Otherwise, reposition the window to match the change in mouse coordinates
        ; caused by the user having dragged the mouse:
        CoordMode, Mouse
        MouseGetPos, EWD_MouseX, EWD_MouseY
        WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
        SetWinDelay, -1   ; Makes the below move faster/smoother.
        WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
        EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
        EWD_MouseStartY := EWD_MouseY
return

ShowTransparencyToolTip:
   ToolTip, %ToolTipText%
   MouseGetPos, MouseX0, MouseY0
   SetTimer, RemoveToolTip
Return

RemoveToolTip:
   If A_TimeIdle < 1000
   {
      MouseGetPos, MouseX, MouseY
      If MouseX = %MouseX0%
      {
         If MouseY = %MouseY0%
         {
            Return
         }
      }
   }
   SetTimer, RemoveToolTip, Off
   ToolTip
Return
