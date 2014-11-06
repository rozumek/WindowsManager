; pokazanie ikony tray'a
Private.App.Tray.ShowTip("Windows Manager " . version, "See Wiki for help")

; menu tray'a
Private.App.Tray.Menu
	.AddSeparatorLine()	
	.AddMenuItem("Restart Application", "restart_app")
	.AddMenuItem("Wiki", "see_wiki")
	.AddMenuItem("About", "about_app")
	.AddMenuItem("Exit", "exit_app")

Rico.Loader.RegisterHotKey("+^#p", "restart_app")

/**
 * ===============================================================================
 * Etykiety z akcjami
 * ===============================================================================
 */
Core() {
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

	exit_app:
		Rico.App.ExitApp()
	return
}