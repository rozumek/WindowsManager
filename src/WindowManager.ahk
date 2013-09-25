/**
 * ======================================================
 * Skrypt zarządzający przeglądarką
 * Wersja: 1.0
 * Autor: marcin.wyrozumski@esky.pl
 * ======================================================
 */

#SingleInstance force 			; file allowed to run only once
#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Recommended for catching common errors.

SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.

/**
 * ================================================================================
 * Sekcja Include
 * ================================================================================
 */
#Include library\Rico.ahk
#Include library\KvalSky.ahk
#Include library\Private.ahk

#Include library\functions.ahk		;funkcje wykorzystywane w projekcie
/**
 * ================================================================================
 */
 
/**
 * ================================================================================
 * Boostrap - początkowe komendy
 * ================================================================================
 */
 
; definiowanie nazwy usera
global username = "Marcin Wyrozumski"
 
; przeglądarki
global browsers := KvalSky.Enum.Browsers

; programy użytkowe
global programs := KvalSky.Enum.Programs
 
; pokazanie ikony tray'a
Private.App.Tray.ShowTip("Windows Manager", "See Wiki for help")

/**
 * ================================================================================
 */
/**
 * ========================================================r=======================
 * Przeładowanie przegladarek
 *
 * Konfiguracja klawiszy: Windows + R + (F|X|C)
 * ================================================================================
 */
#r::
	map := Object()
	map["#f"] := "reload_firefox"
	map["#x"] := "reload_opera"
	map["#c"] := "reload_chrome"
	map["#d"] := "reload_ie"
	
	Rico.Loader.RegisterHotKeysAndWaitForAction(map)
return
/**
 * ===============================================================================
 */

/**
 * ===============================================================================
 * Idz do programu
 *
 * Konfiguracja klawiszy: Windows + A + (F|X|C|T|N|S|E)
 * ===============================================================================
 */
#a::
	map := Object()
	map["#f"] := "goto_firefox"
	map["#x"] := "goto_opera"
	map["#c"] := "goto_chrome"
	map["#t"] := "goto_commander"
	map["#n"] := "goto_notepadpp"
	map["#s"] := "goto_skype"
	map["#e"] := "goto_ide"
	map["#m"] := "goto_outlock"
	map["#d"] := "goto_ie"
	map["#z"] := "goto_putty"
	
	Rico.Loader.RegisterHotKeysAndWaitForAction(map)
return
/**
 * ===============================================================================
 */

 /**
 * ===============================================================================
 * Zarządzanie kursorem
 *
 * Konfiguracja klawiszy: Alt + Windows + W + (1|2)
 * ===============================================================================
 */
#w::
	map := Object()
	map["#1"] := "goto_left_screen"
	map["#2"] := "goto_right_screen"
	
	Rico.Loader.RegisterHotKeysAndWaitForAction(map)
return
/**
 * ===============================================================================
 */

/**
 * ===============================================================================
 * Akcje specjalne
 *
 * Konfiguracja klawiszy: Windows + Q + 
 * ===============================================================================
 */
#q::
	map := Object()
	map["#c"] := "insert_pwc_comment"	
	map["#b"] := "show_actions_box"
	
	Rico.Loader.RegisterHotKeysAndWaitForAction(map)
return
/**
 * ===============================================================================
 */

 
/**
 * ===============================================================================
 * Etykiety z akcjami
 * ===============================================================================
 */
reload_firefox: 
	Rico.Window.RefreshBrowser(browsers["firefox"]["exe"])
return
 
reload_opera:
	Rico.Window.RefreshBrowser(browsers["opera"]["exe"])
return

reload_chrome:
	Rico.Window.RefreshBrowser(browsers["chrome"]["exe"])
return 

reload_ie:
	Rico.Window.RefreshBrowser(browsers["ie"]["exe"], true)
return 

goto_firefox:
	Rico.Window.GotoWindow(browsers["firefox"]["exe"])
return
 
goto_opera:
	Rico.Window.GotoWindow(browsers["opera"]["exe"])
return

goto_chrome:
	Rico.Window.GotoWindow(browsers["chrome"]["exe"], true, false)
return 

goto_ie:
	Rico.Window.GotoWindow(browsers["ie"]["exe"])
return

goto_commander:
	Rico.Window.GotoWindow(programs["commander"]["exe"])
return

goto_notepadpp:
	Rico.Window.GotoWindow(programs["notepadpp"]["exe"])
return

goto_skype:
	Rico.Window.GotoWindow(programs["skype"]["exe"], true, false)
return

goto_ide:
	Rico.Window.GotoWindow(programs["phpstorm"]["exe"], true, false)
return

goto_outlock:
	Rico.Window.GotoWindow(programs["outlook"]["exe"], true, false)
return

goto_putty:
	Rico.Window.GotoWindow(programs["putty"]["exe"], true)
return

goto_left_screen:
	Rico.Cursor.MoveToMonitor(1)
return

goto_right_screen:
	Rico.Cursor.MoveToMonitor(2)
return

insert_pwc_comment:
	PrintPwcAdditionalInfoComment(username)
return

show_actions_box:
	Parser := KvalSky.Algorithm.Parser.SplitArrayItems.getInstance()
	
	Commands := Rico.File.ReadLines(A_ScriptDir . "\data\commands.txt")
						 .ParseFileLines(Parser)
						 .ToArray()
	
	Private.Gui.ListView.GetInstance(600, 20, "#|Opis|Komenda")
						.SetValueRowNumber(3)
						.SetGuiEvents("action_box_events")
					    .SetRows(Commands)
					    .SetAutoSizeColumns(true)
					    .Render()
return

action_box_events:
	if A_GuiEvent = DoubleClick 
	{
		;TODO IMPLEMENT
	}
	
return

