; zarejestrowanie standarowyk klawiszy funkcyjnych
config.SetSection("functions")
Rico.Loader.RegisterHotKey(config.Get("popup.hotkey","#y"), "manager_popup")

Popup() {
	/**
	 * ===============================================================================
	 * Akcje specjalne
	 *
	 * Konfiguracja klawiszy: Windows + Q + 
	 * ===============================================================================
	 */
	manager_popup:
		config.SetSection("popup")

		map := Object()
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


	show_actions_box:
		Parser := KvalSky.Algorithm.Parser.SplitArrayItems.getInstance()
		
		Commands := Rico.File
			.ReadLines(A_ScriptDir . "\data\commands.txt")
			.ParseFileLines(Parser)
			.ToArray()
		
		Private.Gui.ListView
			.GetInstance(600, 20, "#|Opis|Komenda")
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
	
}