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

$title = "Milling"
$win_title = "World of Warcraft"
$screen_width = 1024
$screen_height = 768

HotKeySet("{TAB}", "onHotkeyPress")
$is_running = true;

Opt("GUIOnEventMode", 1)

$window_width = 250
$window_height = 200
$mainwindow = GUICreate($title, $window_width, $window_height, @DesktopWidth - $window_width - 5, @DesktopHeight - $window_height - 50, $WS_CAPTION+$WS_POPUP+$WS_SYSMENU )
GUISetOnEvent($GUI_EVENT_CLOSE, "onClickClose")
$ctrl_trigger_button = GUICtrlCreateButton("Stop", ($window_width/2) - 60, $window_height - 70, 120, 40)
GUICtrlSetOnEvent($ctrl_trigger_button, "onClickTrigger")
$ctrl_status = GUICtrlCreateInput ( "Status", 0, $window_height - 20, $window_width, -1, $ES_LEFT + $ES_READONLY )
GUISetState(@SW_SHOW)

Sleep( 5000 ) 

While $is_running
	If Not WinExists($win_title, "") Then
		Exit
	EndIf
	; Send the Key event "1"
	ControlSend($win_title, "", "", "1")
	Sleep( 1500 )  ; Idle around
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
