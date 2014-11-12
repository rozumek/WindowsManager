; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")
Rico.Loader.RegisterHotKey(config.Get("goto.hotkey","#a"), "manager_goto")

AppGoto(){
	
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
		map[config.Get("navicat.hotkey","#g")] := "goto_navicat"
		map[config.Get("conemu.hotkey","#q")] := "goto_conemu"
		
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
}