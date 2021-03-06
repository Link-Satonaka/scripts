﻿;Link Satonaka
;This script enables you to precisely resize and move a window in one mouse movement.
;Video demonstration: http://1drv.ms/1H8zK8S

;The script operates on the active window. Hold down the modifier key
;(default: XButton1, the "back" button on many mice) and click the left
;mouse button. While still holding both the left mouse button and the
;modifier down, move your mouse anywhere, and let go of the left mouse
;button, then the modifier. The point at which you clicked the left mouse
;button is the new top left coordinate of the active window, and the point
;you let go of the button is the new bottom right coordinate (or the other
;way around, depending on which way you moved the mouse relative to the
;window's previous coordinates). The best way to really understand how it
;works and what you can use it for is to play around with it yourself.

;XButton1 is the modifier, you can change it to whatever you wish. 
;	Just replace every reference of XButton1 to the desired modifier key.
;	If you use X11 mouse hover activation logic, you'll have to hold your modifier before you move the mouse

#NoEnv
#SingleInstance ignore
CoordMode, Mouse, Screen

;Prevent XButton1 from operating on inactive windows under the cursor
;	Likely unnecessary for any other modifier
XButton1 up::
{
	SendInput {XButton1}
}

;Grab the first coordinate of the traced rectangle
XButton1 & LButton::
{
	WinGetTitle, active, A
	WinGet, mize, MinMax, %active%
	MouseGetPos, sto1x, sto1y
	Return
}

;Grab the second coordinate of the traced rectangle, move and resize the window as necessary
XButton1 & LButton up::
{
	MouseGetPos, sto2x, sto2y
	sto3x := sto2x - sto1x
	sto3y := sto2y - sto1y

	if (sto3x < 0 AND sto3y < 0)
	{
		sto3x := sto1x - sto2x
		sto3y := sto1y - sto2y
		if mize = 1
		{
			WinRestore, %active%
		}
		WinMove, %active%,, sto2x, sto2y, sto3x, sto3y
		WinActivate, %active%
		Return
	}

	if sto3x < 0
	{
		sto3x := sto1x - sto2x
		if mize = 1
		{
			WinRestore, %active%
		}
		WinMove, %active%,, sto2x, sto1y, sto3x, sto3y
		WinActivate, %active%
		Return
	}

	if sto3y < 0
	{
		sto3y := sto1y - sto2y
		if mize = 1
		{
			WinRestore, %active%
		}
		WinMove, %active%,, sto1x, sto2y, sto3x, sto3y
		WinActivate, %active%
		Return
	}

	if mize = 1
	{
		WinRestore, %active%
	}

	WinMove, %active%,, sto1x, sto1y, sto3x, sto3y
	WinActivate, %active%
	Return
}
