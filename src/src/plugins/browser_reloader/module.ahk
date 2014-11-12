Rico.Loader.RegisterHotKey(config.Get("reload.hotkey", "#r"), "manager_relaod")

BrowserReloader() {

	
	/**
	 * ========================================================r=======================
	 * Prze�adowanie przegladarekas
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
}