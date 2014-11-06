; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")
Rico.Loader.RegisterHotKey(config.Get("cursor.hotkey","#w"), "manager_cursor")

; ustawienie pozycji monitora g³ównego domyœlnnie lewy
config.SetSection("cursor")
Rico.Window.SetMainScreenPosition(config.Get("main_screen_position", "left"))

CursorManager() {
	
	 /**
	 * ===============================================================================
	 * Zarz¹dzanie kursorem
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
	 * Etykiety z akcjami
	 * ===============================================================================
	 */

	goto_left_screen:	
		Rico.Cursor.MoveToMonitor(1)
	return

	goto_midle_screen:
		Rico.Cursor.MoveToMonitor(2)
	return

	goto_right_screen:
		Rico.Cursor.MoveToMonitor(3)
	return
}