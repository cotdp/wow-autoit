; Copyright 2011 Michael Cutler <m@cotdp.com>
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

$title = "VB"
$win_title = "World of Warcraft"

$screen_width = 1024
$screen_height = 768

HotKeySet("{TAB}", "onHotkeyPress")
$is_running = true;
Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode
$window_width = 250
$window_height = 200
$mainwindow = GUICreate($title, $window_width, $window_height, @DesktopWidth - $window_width - 5, @DesktopHeight - $window_height - 50, $WS_CAPTION+$WS_POPUP+$WS_SYSMENU )
GUISetOnEvent($GUI_EVENT_CLOSE, "onClickClose")
$ctrl_trigger_button = GUICtrlCreateButton("Stop", ($window_width/2) - 60, $window_height - 70, 120, 40)
GUICtrlSetOnEvent($ctrl_trigger_button, "onClickTrigger")
$ctrl_status = GUICtrlCreateInput ( "Status", 0, $window_height - 20, $window_width, -1, $ES_LEFT + $ES_READONLY )
GUISetState(@SW_SHOW)

; Take samples
For $i = 10 to 1 Step -1
	SetStatus( "Sampling postion 1 in " & $i & " seconds" )
	Sleep( 1000 )
Next
SetStatus( "Sampling postion 1" )

$mouse_pos = MouseGetPos()
$mouse1_x = $mouse_pos[0];
$mouse1_y = $mouse_pos[1];

SetStatus( "Mouse position saved at " & $mouse1_x & "x" & $mouse1_y )

; Take samples
For $i = 10 to 1 Step -1
	SetStatus( "Sampling postion 2 in " & $i & " seconds" )
	Sleep( 1000 )
Next
SetStatus( "Sampling postion 2" )

$mouse_pos = MouseGetPos()
$mouse2_x = $mouse_pos[0];
$mouse2_y = $mouse_pos[1];
SetStatus( "Mouse position 2 saved at " & $mouse2_x & "x" & $mouse2_y )

; Setup positions
prepareWarcraft()
$win_pos = WinGetPos($win_title, "")
$pos_x = $win_pos[0] + 230
$pos_y = $win_pos[1] + 330

While $is_running
	
	If Not WinExists($win_title, "") Then
		Exit
	EndIf
	
	MouseMove($mouse1_x, $mouse1_y, 2)
	Sleep(500)
	MouseClick("right");, $pos[0], $pos[1], 1, 2)
	Sleep(2000)
	MouseMove($pos_x, $pos_y, 2)
	Sleep(500)
	MouseClick("left");, $pos[0], $pos[1], 1, 2)
	Sleep(1000)
	MouseMove($mouse1_x, $mouse1_y, 2)
	Sleep(3500)
	Send("{ESCAPE}")

	Sleep( Random(500,5000,1) )
	
	$mouse_pos = MouseGetPos()
	If $mouse1_x <> $mouse_pos[0] Or $mouse1_y <> $mouse_pos[1] Then
		$mouse1_x = $mouse_pos[0];
		$mouse1_y = $mouse_pos[1];
		SetStatus( "Mouse position 1 modified to " & $mouse1_x & "x" & $mouse1_y )
	EndIf

	Sleep( 500 )  ; Idle around

	If Not WinExists($win_title, "") Then
		Exit
	EndIf
	
	; Lhara
	MouseMove($mouse2_x, $mouse2_y, 2)
	Sleep(500)
	MouseClick("right");, $pos[0], $pos[1], 1, 2)
	Sleep(500)
	MouseMove($mouse2_x, $mouse2_y, 2)
	Sleep(2500)
	Send("{ESCAPE}")
	
	Sleep( Random(500,5000,1) )

	$mouse_pos = MouseGetPos()
	If $mouse2_x <> $mouse_pos[0] Or $mouse2_y <> $mouse_pos[1] Then
		$mouse2_x = $mouse_pos[0];
		$mouse2_y = $mouse_pos[1];
		SetStatus( "Mouse position 2 modified to " & $mouse2_x & "x" & $mouse2_y )
	EndIf

	Sleep( 500 )  ; Idle around

WEnd

Exit


Func onClickTrigger()
	; Prepare
	; prepareWarcraft()
	$is_running = false
EndFunc


Func onClickClose()
  SetStatus( "Exiting..." )
  Exit
EndFunc


Func onHotkeyPress()
	Exit
EndFunc


Func SetStatus( $msg )
	GUICtrlSetData( $ctrl_status, $msg )
EndFunc


Func detectWarcraft()
	If Not WinExists($win_title, "") Then
		SetStatus( $win_title & " not detected" )
		Return False
	Else
		$dimensions = WinGetClientSize($win_title, "")
		SetStatus("Detected window size " & $dimensions[0] & "x" & $dimensions[1] )
		Return True
	EndIf
EndFunc


Func prepareWarcraft()
	WinActivate($win_title, "")
	WinSetOnTop($win_title, "", 0)
	Sleep(500)

	$win_pos = WinGetPos($win_title, "")
	; $win_x = $win_pos[0]
	; $win_y = $win_pos[1]

EndFunc
