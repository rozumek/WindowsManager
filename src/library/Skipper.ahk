class Skipper {

	class Loader {
	
		AutoloadTmpFileName := "autoload.tmp"
		ModulesDirPath := "src\plugins\"
		ModuleFileName := "module.ahk"
		
		LoaderExists() {
			autoloadFile := this.AutoloadTmpFileName
			return FileExist(autoloadFile) <> ""
		}
		
		Cleanup() {
			autoloadFile := this.AutoloadTmpFileName
			FileDelete %autoloadFile%
			
			return this
		}
		
		GetAutoloaderName() {
			return this.AutoloadTmpFileName
		}
		
		LoadModules(modules) {
			this.Cleanup()
			
			autoloadFile := this.AutoloadTmpFileName
			modulesDirPath := this.ModulesDirPath
			moduleFileName := this.ModuleFileName
			
			for moduleId, module in modules {
				modulePath := "#Include " . modulesDirPath . module . "\" . moduleFileName . "`n"
				FileAppend, %modulePath%, %autoloadFile%
			}			
			
			return this
		}
		
	}
	
}