; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")
Rico.Loader.RegisterHotKey(config.Get("windows.hotkey","#x"), "manager_windows")

Calendar() {
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

	open_windows_calendar:
		Send #t{Tab}{Tab}{Left}{Enter}
	return
}