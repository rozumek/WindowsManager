/**
 * ======================================================
 * Skrypt zarządzający przeglądarką
 * Wersja: 1.0.1 Aplha
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

 
 /**
  * ================================================================================
  * Ustawienie wersji
  * ================================================================================
  */
global version := "1.0.1 Beta"
 /* 
  * ================================================================================
  */

; pobranie konfiga aplikacji
global config := Rico.Config.LoadFromIni(A_ScriptDir . "\config\main.ini", "general")
 
; przeglądarki
global browsers := KvalSky.Enum.Browsers

; programy użytkowe
global programs := KvalSky.Enum.Programs
 
; pokazanie ikony tray'a
Private.App.Tray.ShowTip("Windows Manager " . version, "See Wiki for help")

; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")

Rico.Loader.RegisterHotKey(config.Get("reload.hotkey", "#r"), "manager_realod")
Rico.Loader.RegisterHotKey(config.Get("goto.hotkey","#a"), "manager_goto")
Rico.Loader.RegisterHotKey(config.Get("cursor.hotkey","#w"), "manager_cursor")
Rico.Loader.RegisterHotKey(config.Get("pwc.hotkey","#q"), "manager_pwc")

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
manager_realod:
	config.SetSection("browsers")
	
	map := Object()
	map[config.Get("firefox.hotkey","#f")] := "reload_firefox"
	map[config.Get("opera.hotkey","#x")] := "reload_opera"
	map[config.Get("chrome.hotkey","#c")] := "reload_chrome"
	map[config.Get("ie.hotkey","#d")] := "reload_ie"
	
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
manager_goto:
	config.SetSection("programs")
	
	map := Object()
	map[config.Get("firefox.hotkey","#f")] := "goto_firefox"
	map[config.Get("opera.hotkey","#x")] := "goto_opera"
	map[config.Get("chrome.hotkey","#c")] := "goto_chrome"
	map[config.Get("commender.hotkey","#t")] := "goto_commander"
	map[config.Get("notepadpp.hotkey","#n")] := "goto_notepadpp"
	map[config.Get("skype.hotkey","#s")] := "goto_skype"
	map[config.Get("ide.hotkey","#e")] := "goto_ide"
	map[config.Get("outlook.hotkey","#m")] := "goto_outlook"
	map[config.Get("ie.hotkey","#d")] := "goto_ie"
	map[config.Get("putty.hotkey","#z")] := "goto_putty"
	
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
manager_cursor:
	config.SetSection("cursor")

	map := Object()
	map[config.Get("goto_left_screen.hotkey","#1")] := "goto_left_screen"
	map[config.Get("goto_right_screen.hotkey","#2")] := "goto_right_screen"
	
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
manager_pwc:
	config.SetSection("pwc")

	map := Object()
	map[config.Get("insert_pwc_comment.hotkey","#c")] := "insert_pwc_comment"	
	map[config.Get("show_actions_box.hotkey","#b")] := "show_actions_box"
	
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
	Rico.Window.RefreshBrowser(browsers["firefox"]["exe"], true)
return
 
reload_opera:
	Rico.Window.RefreshBrowser(browsers["opera"]["exe"])
return

reload_chrome:
	Rico.Window.RefreshBrowser(browsers["chrome"]["exe"], true)
return 

reload_ie:
	Rico.Window.RefreshBrowser(browsers["ie"]["exe"])
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
	Rico.Window.GotoWindow(browsers["ie"]["exe"], true)
return

goto_commander:
	Rico.Window.GotoWindow(programs["commander"]["exe"])
return

goto_notepadpp:
	Rico.Window.GotoWindow(programs["notepadpp"]["exe"])
return

goto_skype:
	Rico.Window.GotoWindow(programs["skype"]["exe"], false, false)
return

goto_ide:
	Rico.Window.GotoWindow(programs["phpstorm"]["exe"], true, false)
return

goto_outlook:
	Rico.Window.GotoWindow(programs["outlook"]["exe"], true, false)
return

goto_putty:
	Rico.Window.GotoWindow(programs["putty"]["exe"], true, false)
return

goto_left_screen:
	Rico.Cursor.MoveToMonitor(1)
return

goto_right_screen:
	Rico.Cursor.MoveToMonitor(2)
return

insert_pwc_comment:
	config.SetSection("general")
	username := config.Get("username", "User")

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
		SelectedRowText := Private.Gui.ListView.CopySelectedValueToClipboard()
		MsgBox %SelectedRowText%		
	}
	
return

