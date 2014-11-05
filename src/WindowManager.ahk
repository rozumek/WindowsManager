/**
 * ======================================================
 * Skrypt zarządzający przeglądarką
 * Wersja: 1.1.1 Alpha
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
global version := "1.1.1"
global wiki := "https://github.com/rozumek/WindowsManager/wiki"
global homepage := "https://github.com/rozumek/WindowsManager/wiki"
 /* 
  * ================================================================================
  */

; pobranie konfiga aplikacji

try {
	global config := Rico.Config.LoadFromIni(A_ScriptDir . "\config\main.ini", "general")
} catch e {
	MsgBox Problem loading main.ini config file
	ExitApp
}
 
; przeglądarki
global browsers := KvalSky.Enum.Browsers

; programy użytkowe
global programs := KvalSky.Enum.Programs
 
; pokazanie ikony tray'a
Private.App.Tray.ShowTip("Windows Manager " . version, "See Wiki for help")

; menu tray'a
Private.App.Tray.Menu
	.AddSeparatorLine()	
	.AddMenuItem("Restart Application", "restart_app")
	.AddMenuItem("Wiki", "see_wiki")
	.AddMenuItem("About", "about_app")
	.AddMenuItem("Exit", "exit_app")

; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")

Rico.Loader.RegisterHotKey("+^#r", "restart_app")

Rico.Loader.RegisterHotKey(config.Get("reload.hotkey", "#r"), "manager_relaod")
Rico.Loader.RegisterHotKey(config.Get("goto.hotkey","#a"), "manager_goto")
Rico.Loader.RegisterHotKey(config.Get("cursor.hotkey","#w"), "manager_cursor")
Rico.Loader.RegisterHotKey(config.Get("pwc.hotkey","#q"), "manager_pwc")
Rico.Loader.RegisterHotKey(config.Get("windows.hotkey","#x"), "manager_windows")

; ustawienie pozycji monitora głównego domyślnnie lewy
config.SetSection("cursor")
Rico.Window.SetMainScreenPosition(config.Get("main_screen_position", "left"))

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
manager_relaod:
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
	map[config.Get("tortoise.hotkey","#v")] := "goto_tortoise"
	map[config.Get("navicat.hotkey","#r")] := "goto_navicat"
	map[config.Get("conemu.hotkey","#q")] := "goto_conemu"
	
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
	map[config.Get("goto_midle_screen.hotkey","#2")] := "goto_midle_screen"
	map[config.Get("goto_right_screen.hotkey","#3")] := "goto_right_screen"
	
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
 * Akcje specjalne
 *
 * Konfiguracja klawiszy: Windows + Shift + 
 * ===============================================================================
 */
manager_windows:
	config.SetSection("windows")

	map := Object()
	map[config.Get("calendar.hotkey","wc")] := "open_windows_calendar"		
	
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
	config.SetSection("browsers")
	Rico.Window.RefreshBrowser(browsers["firefox"]["exe"], config.Get("firefox.autoaccept", true))
return
 
reload_opera:
	config.SetSection("browsers")
	Rico.Window.RefreshBrowser(browsers["opera"]["exe"], config.Get("opera.autoaccept", false))
return

reload_chrome:
	config.SetSection("browsers")
	Rico.Window.RefreshBrowser(browsers["chrome"]["exe"], config.Get("chrome.autoaccept", true))
return 

reload_ie:
	config.SetSection("browsers")
	Rico.Window.RefreshBrowser(browsers["ie"]["exe"], config.Get("ie.autoaccept", true))
return 

goto_firefox:
	config.SetSection("browsers")
	Rico.Window.GotoWindow(browsers["firefox"]["exe"], config.Get("firefox.extended", false), config.Get("firefox.maximize", true))
return
 
goto_opera:
	config.SetSection("browsers")
	Rico.Window.GotoWindow(browsers["opera"]["exe"], config.Get("opera.extended", false), config.Get("opera.maximize", true))
return

goto_chrome:
	config.SetSection("browsers")
	Rico.Window.GotoWindow(browsers["chrome"]["exe"], config.Get("chrome.extended", true), config.Get("chrome.maximize", false))
return 

goto_ie:
	config.SetSection("browsers")
	Rico.Window.GotoWindow(browsers["ie"]["exe"], config.Get("ie.extended", true), config.Get("ie.maximize", true))
return

goto_commander:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["commander"]["exe"], config.Get("commander.extended", false), config.Get("commander.maximize", true))
return

goto_conemu:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["conemu"]["exe"], config.Get("conemu.extended", false), config.Get("conemu.maximize", false))
return 

goto_notepadpp:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["notepadpp"]["exe"], config.Get("notepadpp.extended", false), config.Get("notepadpp.maximize", true))
return

goto_skype:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["skype"]["exe"], config.Get("skype.extended", false), config.Get("skype.maximize", false))
return

goto_ide:
	config.SetSection("programs")
	app := config.Get("ide.app", "phpstorm")
	
	if (!Rico.Array.KeyExist(app, programs)) {
		MsgBox Uknown ide: %app%
	} else {	
		Rico.Window.GotoWindow(programs[app]["exe"], config.Get("ide.extended", true), config.Get("ide.maximize", false))
	}
return

goto_outlook:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["outlook"]["exe"], config.Get("outlook.extended", true), config.Get("outlook.maximize", false))
return

goto_putty:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["putty"]["exe"], config.Get("putty.extended", true), config.Get("putty.maximize", false))
return

goto_tortoise:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["tortoise"]["class"], config.Get("tortoise.extended", true), config.Get("tortoise.maximize", false), "ahk_class")
return

goto_navicat:
	config.SetSection("programs")
	Rico.Window.GotoWindow(programs["navicat"]["exe"], config.Get("navicat.extended", true), config.Get("navicat.maximize", false), "ahk_class")
return

goto_left_screen:	
	Rico.Cursor.MoveToMonitor(1)
return

goto_midle_screen:
	Rico.Cursor.MoveToMonitor(2)
return

goto_right_screen:
	Rico.Cursor.MoveToMonitor(3)
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

restart_app:
	Rico.App.ReloadApp()	
return

see_wiki:
	Rico.App.Run(wiki)
return

about_app:
	config.SetSection("general")
	appName := config.Get("app_name") . " " . version . " - Open source"
	
	MsgBox, %appName%`n`nCreated by: `tMarcin Wyrozumski`nPowered by: `tAutoHotKey`nHomepage: `t%homepage%`n`nPlease Share It!!!
return

open_windows_calendar:
	Send #t{Tab}{Tab}{Left}{Enter}
return

exit_app:
	Rico.App.ExitApp()
return

