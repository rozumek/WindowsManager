class Bootstrap
{
	__New() 
	{
		 /**
		  * ================================================================================
		  * Setting global data
		  * ================================================================================
		  */
		global version := "1.2.0 Alpha"
		global wiki := "https://github.com/rozumek/WindowsManager/wiki"
		global homepage := "https://github.com/rozumek/WindowsManager/wiki"

		global browsers := KvalSky.Enum.Browsers
		global programs := KvalSky.Enum.Programs

		 /**
		  * ================================================================================
		  * Getting global fonfiguration
		  * ================================================================================
		  */
		try {
			global config := Rico.Config.LoadFromIni(A_ScriptDir . "\config\main.ini", "general")
		} catch e {
			MsgBox Problem loading main.ini config file
			ExitApp
		}
	}
}