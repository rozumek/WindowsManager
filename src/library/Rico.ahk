class Rico {

	/**
	 * Namespace z funkcjami tabel
	 */
	class Array {
		/**
		 * Funkcja zliczajaca ile jest elementów w tablicy
		 *
		 * @param array array
		 * @return int
		 */
		Count(inputArray) {
			counter := 0
			
			for index, value in inputArray {
				counter += 1
			}

			return counter
		}

		/**
		 * Funkcja zwraca dany element z tablicy lub zwraca parametr domyślny
		 *
		 * @param array array
		 * @param string|int key
		 * @param mixed|string default
		 * @return mixed
		 */
		Get(inputArray, key, defaultValue := "") {		
			if (this.KeyExist(key, inputArray)) {
				return inputArray[key]
			}
			
			return defaultValue
		}

		/**
		 * Funkcja sprawdzajaca czy element jest w tablicy
		 *
		 * @param mixed needle
		 * @param array haystack
		 * @return bool
		 */
		InArray(needle, haystack) {
			for index, value in  haystack {
				if(value == needle) {
					return true
				}
			}
			
			return false
		}
		
		/**
		 * Funkcja łacząca elementy tablicy w ciag znaków oddzielanych łącznikeim
		 *
		 * @param array array
		 * @param string glue
		 * @return bool
		 */
		Join(inputArray, glue :="") {
			stringResult := ""			
			iterator := 0

			for index, value in  inputArray {
				if (iterator != 0) {
					stringResult .= glue
				}
				
				stringResult .= value
			}

			return stringResult
		}

		/**
		 * Funkcja sprawdzajaca czy klucz jest w tablicy
		 *
		 * @param mixed key
		 * @param array array
		 * @return bool
		 */
		KeyExist(key, inputArray) {
			for index, value in  inputArray {
				if(index == key) {
					return true
				}
			}
			
			return false
		}
	}
	
	/**
	 * Namespace zarządzajacy Configiem
	 */
	class Config {		
		/**
		 * tablica zmiennych konfiguracyjnych
		 *
		 * @return array
		 */
		Config := ""
	
		/**
		 * Nazwa pliku z konfiguracją
		 *
		 * @var string
		 */
		FileName := ""
	
		/**
		 * Zwraca sekcje z pliku Ini
		 *
		 * @return this
		 */
		Section := ""
	
		/**
		 * Pobiera konfiguracje z pliku
		 *
		 * @retrun this
		 */
		LoadFromIni(FileName, DefaultSection) {	
			this.SetFileName(FileName)
			this.SetSection(DefaultSection)
			
			if(!Rico.File.Exist(this.FileName)) {
				throw Exception("Configuration file: " . FileName " not exists", -1)
			}
			
			return this
		}
					
		/**
		 * Ustawia sekcje z jakiej będa pobierane dane
		 *
		 * @retrun this
		 */
		SetSection(Section) {
			this.Section := Section
			return this
		}			

		/**
		 * Zwraca nazwe pliku INI
		 *
		 * @retrun string
		 */
		GetFileName() {
			return this.FileName
		}
		
		/**
		 * Ustawie nazwe pliku INI
		 *
		 * @retrun this
		 */
		SetFileName(FileName) {
			this.FileName := FileName
			return this
		}			

		/**
		 * Zwraca nazwe sekcji z jakiej beda pobierane dane
		 *
		 * @retrun string
		 */
		GetSection() {
			return this.Section
		}
		
		/**
		 * Pobiera zmienna konfiguracyjna
		 *
		 * @param string Key
		 * @param mixed Default
		 * @retrun string|bool
		 */
		Get(Key, Default:="") {
			Section := this.GetSection()
			FileName := this.GetFileName()
			IniRead, ConfigVar, %FileName%, %Section%, %Key%, %Default%
			
			/**
			 * Issue[21] Main.ini does not work properly
			 *
			 * Boolean values processing
			 */
			if (ConfigVar == "true") {
				ConfigVar := true
			} else if (ConfigVar == "false") {
				ConfigVar := false
			}

			return ConfigVar
		}
		
		ToArray() {
			
		}
	}
	
	/**
	 * Namespace zarządzający kursorem myszy
	 */
	class Cursor {
		/**
		 * Funkcja przenoci kursor na wybrani monitor
		 *
		 * @param iint
		 */
		MoveToMonitor(monitorId) { 	
			SysGet, MonitorCount, MonitorCount
			
			if (MonitorCount > 1) {
				CoordMode, Mouse, Screen
				SysGet, MonitorR, Monitor, 1
				SysGet, MonitorL, Monitor, 2
				
				rightMonitorCenterX := (MonitorRRight - MonitorRLeft)/2
				rightMonitorCenterY := (MonitorRBottom - MonitorRTop)/2
				leftMonitorCenterX := (MonitorLRight - MonitorLLeft)/2
				leftMonitorCenterY := (MonitorLBottom - MonitorLTop)/2
			
				if (monitorId = 2) {										
					MouseMove, rightMonitorCenterX, rightMonitorCenterY
				} else if(monitorId = 1) {					
					MouseMove, -leftMonitorCenterX, leftMonitorCenterY
				}
			}
		}
	}
	
	/**
	 * Namespace pracujący na plikach
	 */
	class File {
		/**
		 * Nazwa pliku
		 *
		 * @var string
		 */
		FileName := ""
		
		/**
		 * tablica z liniami z pliku
		 *
		 * @var array
		 */
		FileLines := Object()
		
		/**
		 * Surowa zawartość pliku
		 *
		 * @var string
		 */
		FileContent := ""
		
		/**
		 * Ustawia nazwe pliku
		 *
		 * @param string FileName
		 * @return this
		 */
		SetFileName(FileName) {
			this.FileName := FileName
			return this
		}
		
		/**
		 * Pobiera nazwe pliku
		 *
		 * @return string
		 */
		GetFileName() {
			return this.FileName
		}	

		/**
		 * Sprawdza czy plik istnieje
		 *
		 * @return bool
		 */
		Exist(FileName) {
			if(FileExist(FileName)) {
				return true
			} else {
				return false
			}
		}
		
		/**
		 * Pobiera surową zawartość pliku
		 *
		 * @return string
		 */
		ReadContent(FileName) {
			if(this.Exist(FileName)) {
				FileRead, FileContent, %FileName%				
				return FileContent
			}
			
			return ""
		}
		
		/**
		 * Ładowanie pliku do tablicy
		 *
		 * @param string FileName
		 * @return this
		 */
		ReadLines(FileName := "") {
			this.Flush()
			
			if(FileName == "") {
				FileName := this.GetFileName()
			} else {
				this.SetFileName(FileName)
			}
			
			Loop, Read, %FileName% 
			{
				this.FileLines.Insert(A_LoopReadLine) ; Append this line to the array.
			}
			
			return this
		}
		
		/**
		 * Parsuje tablice z liniami pliku
		 *
		 * @param KvalSky_AbstractParser Parser
		 * @return this
		 */
		ParseFileLines(Parser) {
			if (IsObject(Parser)) {
				this.FileLines := Parser.Parse(this.FileLines)
			}
			
			return this
		}
		
		/**
		 * Czyszczenie tablicyc z danymi
		 *
		 * @return void
		 */
		Flush() {
			this.FileLines := Object()
			
			return this
		}
		
		/**
		 * Zwraca tablice elementów pobranyc z pliku 
		 *
		 *
		 */
		ToArray() {
			return this.FileLines
		}
	}
	
	/**
	 * Namespace Ładujący
	 */
	class Loader {
		/**
		 * Funkcja rejestrowujaca skrórt klawiszowy do makra
		 *
		 * @param string key
		 * @param string macro
		 */
		RegisterHotKey(key, macro) {
			if IsLabel(macro) {
				Hotkey, %key%, %macro%  
				Hotkey, %key%, On
			}
		}

		/**
		 * Funkcja rejestruje klawisze do makr
		 *
		 * @param array map
		 * @return bool
		 */
		RegisterHotKeys(map) {
			if IsObject(map) {
				For key, macro in map {
					this.RegisterHotKey(key, macro)
				}
				
				return true
			}

			return false
		}

		/**
		 * Funkcja odrejestrowuje klawisze do makr
		 *
		 * @param array map
		 * @return bool
		 */
		UnRegisterHotKeys(map) {
			if IsObject(map) {
				For key, macro in map {
					if IsLabel(macro) {			
						this.UnRegisterHotKey(key)
					}
				}
				
				return true
			}

			return false
		}

		/**
		 * Funkcja odrejestrowujaca skrórt klawiszowy
		 *
		 * @param string key
		 */
		UnRegisterHotKey(key) {
		  Hotkey, %key%, Off
		}

		/**
		 * Funckja rejestrujaca map klawiszy do makr, czekająca zadany okres czasu na akcje oraz odrejestowujaca
		 */
		RegisterHotKeysAndWaitForAction(map, waitTime := 1000, specialKey := "#") {
			this.RegisterHotKeys(map)

			KeyWait, %specialKey%
			Sleep, %waitTime%
			
			this.UnRegisterHotKeys(map)
		}
	}
		
	/**
	 * Namespace zarzadzający oknami
	 */
	class Window {		
		
		/**
		 * Funkcja przeładowujaca stronę
		 */
		ReloadPage(autoAccept := false) {
			Send ^r	
			
			if(autoAccept == true) {				
				Send {Enter}
			}
		}

		/**
		 * Funkcja przeładowujaca przegladarke 
		 *
		 * @param string browser
		 */
		RefreshBrowser(window, autoAccept := false) {
			if this.GotoWindow(window) {
				this.ReloadPage(autoAccept)
			}
		}

		/**
		 * Funkcja zwraca liste uruchomionych okien
		 *
		 * @return array
		 */
		GetWindowsList() {
			WinGet, windowList, List	
			return windowList
		}

		/**
		 * Funkcja kierujaca do  przegladarki
		 *
		 * @param string browser
		 * @return bool
		 */
		GotoWindow(window, extended := false, forceMaximize := true, ahkType := "ahk_exe") {
			if WinExist(ahkType . " " . window){				
				if (extended == true) {
					WinGet, windowList, List	
					WinGetClass, baseWindowClass, %ahkType% %window%
					
					loop  %windowList%{
						windowItem := windowList%A_Index%				
						WinGetClass, windowClass, ahk_id%windowItem%								
													
						if(windowClass == baseWindowClass) {	
							WinGetTitle, windowTitle, ahk_id %windowItem%
							WinGet windowId, ID, ahk_id %windowItem%
							
							if(!WinActive("ahk_id " . windowId)) {						
								WinActivate ahk_id %windowId%						
								WinGet maximized, MinMax, ahk_id %windowItem%
								
								if(!maximized && forceMaximize == true) {
									WinMaximize ahk_id %windowId%
								}
								
								break
							}
						}
					}		
				} else {
					if(!WinActive(ahkType . " " . window)) {
						WinActivate
						WinGet maximized, MinMax, ahk_exe %window%				
						
						if (!maximized && forceMaximize == true) {
							WinMaximize	
						}					
					}
				}
				
				return true
			} else {
				MsgBox Window %window% not active		
				
				return false
			}
		}

		/**
		 * Funkcja pobiera Id monitora głównego
		 *
		 * @return string
		 */
		GetPrimatyMonitorId() {
			SysGet, MonitorPrimaryId, MonitorPrimary
			return MonitorPrimaryId
		}
	}
	
}