class Bootstrap {

	version := "1.2.0 Alpha"
	wiki := "https://github.com/rozumek/WindowsManager/wiki"
	homepage := "https://github.com/rozumek/WindowsManager/wiki"
	browsers := {}
	programs := {}
	config := {}
	
	__New() {
		
		this.browsers := KvalSky.Enum.Browsers
		this.programs := KvalSky.Enum.Programs

		try {
			this.config := Rico.Config.LoadFromIni(A_ScriptDir . "\config\main.ini", "general")
		} catch e {
			MsgBox Problem loading main.ini config file
			ExitApp
		}
	}
	
	Run(){
		
	}
}