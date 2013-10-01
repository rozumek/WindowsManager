class Private {

	/**
	 * Elementy aplikacji
	 */
	class App {
		
		/**
		 * Iconka Tray
		 */
		class Tray {
			
			/**
			 * Pokazuje Ikonke Tray z opisem
			 *
			 * @param string Title
			 * @param string Description
			 * @param int Seconds
			 * @param int Option (Available 1 - Info Icon, 2 - Warning Icon, 3 - Error icon)
			 * @return this
			 */
			ShowTip(Title, Description, Seconds := 5, Option := 1) {
				TrayTip, %Title%, %Description%, %Seconds%, %Option%
				
				return this
			}
		}
	}
	
	/**
	 * Elementy Gui
	 */
	class Gui {
		
		class AbstractGuiElement {
			/**
			 * Flaga czy okolumny maja byc auto wyrównywalne
			 *
			 * @var bool
			 */
			AutoSizeColumns := false
			
			/**
			 * Nazwa marka z eventami okna
			 *
			 * @var string
			 */
			EventsLabel := ""
			
			/**
			 * Komunikat przy zamykaniu okna
			 *
			 * @var string
			 */
			static CloseMessage := "`n`nShould window be closed?"
			
			/**
			 * Czy okno ma byc zamkniete
			 *
			 * @var string
			 */
			static CloseConfirmEnable := true			
			
			/**
			 * Metoda ustawiajaca etykiete dla eventów
			 *
			 * @param string EventsLabel
			 * @return this
			 */	
			SetGuiEvents(EventsLabel) {
				this.EventsLabel := EventsLabel
				return this				
			}
			
						
			/**
			 * Metoda pobierajaca etykiete dla eventów
			 *			
			 * @return string
			 */
			GetGuiEvents() {
				return this.EventsLabel
			}
			
			/**
			 * Metoda ustawiajaca flage 
			 *
			 * @param bool Flag
			 * @return this
			 */	
			SetAutoSizeColumns(Flag) {
				if(Flag){
					this.AutoSizeColumns := true
				} else {
					this.AutoSizeColumns := false
				}
				
				return this
			}
			
			/**
			 * Metoda pobierajaca flage
			 *			
			 * @return bool
			 */	
			GetAutoSizeColumns() {
				return this.AutoSizeColumns
			}
			
			/**
			 * Metoda rendereujaca box
			 *
			 * @abstract
			 * @param array Rows
			 * @return this
			 */	
			Render() {
				
			}
			
			Destroy() {
				Gui Destroy
			}
			
			/**
			 * Metoda przechowuje wszystki makra dla eventów, nie powinn abyć wywołana
			 * Metoda powinna byc zaimplementowana w potomnych klasach
			 */
			Events() {
				return this
			}
		}
		
		/**
		 * Box z listą
		 */
		class ListView extends Private.Gui.AbstractGuiElement{
			/**
			 * Identyfikator okna
			 *
			 * @var int
			 */
			static Id := 0
			
			/**
			 * Lista dostepnych HotKey dla Gui
			 *
			 * @var array
			 */
			static GuiEventsHotKeyMap := {"Escape" : "gui_listview_event_close", "^c" : "gui_listview_copy_action"}	
			
			/**
			 * Numer kolumny której wartosc ma byc zwrócona
			 *
			 */
			static ValueRowNumber := 1
			
			/**
			 * Komunikat ze nalezy wybrac okno
			 *
			 * @var string
			 */
			static SelectionErrorText := "Choose a row to copy"
			
			/**
			 * Szerorkosc okna
			 *
			 * @var int
			 */
			Width := 60
			
			/**
			 * Wysokosc okna
			 *
			 * @var int
			 */
			Height := 20
			
			/**
			 * Nazwy kolumn okna
			 *
			 * @var string
			 */
			HeaderColumnNames := "Column1"
			
			/**
			 * Wiersze
			 *
			 * @var int
			 */
			Rows := []
			
			/**
			 * Konstruktor
			 *
			 * @param int Width
			 * @param int Height
			 * @param string HeaderColumnNames
			 * @param string EventsLabel
			 * @return this
			 */
			GetInstance(Width := 0, Height := 0, HeaderColumnNames := "", EventsLabel="") {				
				this.Id++
				
				;domyslne ustawienie pierwszej kolumny dla kazdego nowego elementu
				this.SetValueRowNumber(1)
				
				if(Width > 0){
					this.Width := Width
				}
				if(Height > 0) {
					this.Height := Height
				}
				if(HeaderColumnNames != "") {
					this.HeaderColumnNames := HeaderColumnNames
				}
				if(EventsLabel != "") {
					this.EventsLabel := EventsLabel
				}	

				return this
			}
			
			Destroy() {
				Gui Destroy
				Private.Gui.UnRegisterGuiKeyEvents(Private.Gui.ListView.GuiEventsHotKeyMap)
				Private.Gui.ListView.Id--
			}
			
			/**
			 * Metoda ustawiajaca numer kolumny do wyswietlenia
			 *
			 * @param int Number
			 * @return this
			 */	
			SetValueRowNumber(Number) {
				this.ValueRowNumber := Number
				return this
			}
			
			/**
			 * Metoda zwwraca numer kolumny do wyswietlenia
			 *			 
			 * @return int
			 */	
			GetValueRowNumber() {
				return this.ValueRowNumber
			}
			
			/**
			 * Metoda ustawiajaca wiersze
			 *
			 * @param array Rows
			 * @return this
			 */			 
			SetRows(Rows) {
				this.Rows := Rows
				return this
			}
			
			/**
			 * Metoda pobierajaca wiersze
			 *
			 * @return array
			 */	
			GetRows() {
				return this.Rows
			}
			
			/**
			 * Metoda ustawia naglówki dla kolumn
			 *
			 * @param string HeaderColumnNames
			 * @return this
			 */	
			SetHeaderColumnNames(HeaderColumnNames) {
				this.HeaderColumnNames := HeaderColumnNames
				return this
			}
			
			/**
			 * Metoda pobierajaca naglówki dla kolumn
			 *			
			 * @return string
			 */
			GetHeaderColumnNames() {
				return this.HeaderColumnNames
			}
			
			/**
			 * Metoda rendereujaca box
			 *
			 * @param array Rows
			 * @return this
			 */	
			Render() {
				Height := this.Height
				Width := this.Width
				EventsLabel := this.EventsLabel
				HeaderColumnNames := this.HeaderColumnNames
				
				Gui, Add, ListView, r%Height% w%Width% g%EventsLabel%, %HeaderColumnNames%
				
				for i, element in this.Rows {			
					LV_Add("", i, element*)
				}
				
				if (this.AutoSizeColumns) {
					LV_ModifyCol()
				}
				
				Gui, Show
				
				Private.Gui.RegisterGuiKeyEvents(Private.Gui.ListView.GuiEventsHotKeyMap)
				
				return this
			}

			/**
			 * Zwraca numer zaznaczonego wiersza
			 *
			 * @return int
			 */	
			GetSelectedRowNumber() {
				return LV_GetNext("Selected")
			}
			
			/**
			 * Zwraca wartość kolumny
			 *
			 * @param int Column
			 * @return string
			 */	
			GetSelectedRowValue(Column:=1) {
				RowNumber := Private.Gui.ListView.GetSelectedRowNumber()							
				LV_GetText(RowValue, RowNumber, Column)
				
				return RowValue
			}
			
			/**
			 * Metoda przechowuje wszystki makra dla eventów, nie powinn abyć wywołana
			 */
			Events() {
				return this
				
				/**
				 * Kopiowanie do schowka bierzącej wartosci
				 */
				gui_listview_copy_action:
					if (WinActive("ahk_class AutoHotkeyGUI")) {		
						if(Private.Gui.ListView.GetSelectedRowNumber() > 0){							
							RowText := Private.Gui.ListView.GetSelectedRowValue(Private.Gui.ListView.ValueRowNumber)
							Clipboard = %RowText%
							
							if (Private.Gui.ListView.CloseConfirmEnable){
								CloseConfirmation := Private.Gui.ListView.CloseMessage
								MsgBox, 4, , %RowText% %CloseConfirmation%
								
								IfMsgBox Yes  
								{
									Private.Gui.ListView.Destroy()
								}
							} else {
								MsgBox %RowText%
							}
						} else {
							SelectionErrorText := Private.Gui.ListView.SelectionErrorText
							MsgBox %SelectionErrorText%					
						}
					}
				return 
				
				/**
				 * Zamykanie GUI
				 */			 
				gui_listview_event_close:
					if (WinActive("ahk_class AutoHotkeyGUI")) {
						Private.Gui.ListView.Destroy()					
					}
				return 
			}
		}	
		
		/**
		 * Uruchomienie eventów okna
		 *
		 * @return this
		 */
		RegisterGuiKeyEvents(GuiEventsHotKeyMap) {
			Rico.Loader.RegisterHotKeys(GuiEventsHotKeyMap)	
			return this
		}	

		/**
		 * Wyłączenie eventów okna
		 *
		 * @return this
		 */
		UnRegisterGuiKeyEvents(GuiEventsHotKeyMap) {		
			Rico.Loader.UnRegisterHotKeys(GuiEventsHotKeyMap)						
			return this
		}
	}	
	
}


