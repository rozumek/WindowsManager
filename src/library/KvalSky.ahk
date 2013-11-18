class KvalSky {

	/**
	 * Namespace z algorytmami
	 */
	class Algorithm {

		/**
		 * Namespace Parsera
		 */
		class Parser {
			
			/**
			 * Klasa abstrakcyjna dla Parserów
			 */
			class AbstractParser {
				/**
				 * Pobiera instancje parsera
				 *
				 * @return KvalSky_Parser_Abstract
				 */
				GetInstance() {
					return this
				}

				/**
				 * Metoda parsujaca
				 *
				 * @abstract
				 * @variadic
				 * @args
				 */
				Parse(args*) {
				
				}
			}
			
			/**
			 * Parser parsujacy elementy tablicy
			 */
			class SplitArrayItems extends KvalSky.Algorithm.Parser.AbstractParser {		

				/**
				 * Funkcja parsująca elementy tablicy
				 *
				 * @param array Rowset
				 * @param string Delimiter
				 * @return array
				 */
				Parse(Rowset, Delimiter := ";") {
					ResultArray := Object()					
					
					for i, element in Rowset {	
						ItemsRaw := Object()
						Items := Object()
						
						Loop, Parse, element, %Delimiter%, 
						{
							Items[A_Index] := A_LoopField
						}
						
						ResultArray[i] := Items
					}
					
					return ResultArray
				}
			}
		}		
		
	}
	
		
	/**
	 * Namespace z enumami
	 */
	class Enum {
		/**
		 * Enum z informacjami o Przeglądarkach
		 */
		static Browsers := {chrome : {exe : "chrome.exe"}, ie : {exe : "ie.exe"}, firefox : {exe : "firefox.exe"}, opera : {exe : "opera.exe"}}
		
		/**
		 * Enum z informacjami programach
		 */
		static Programs := {commander : {exe : "TOTALCMD64.exe", class : "TTOTAL_CMD"}, putty : {exe : "putty.exe", class : "PuTTY"}, outlook : {exe : "OUTLOOK.EXE", class : "rctrl_renwnd32"}, phpstorm : {exe : "PhpStorm.exe", class : "SunAwtFrame"}, skype :{exe : "Skype.exe", : class : "tSkMainForm"}, notepadpp : {exe : "notepad++.exe", class : "Notepad++"}, tortoise :{exe : "", class : "#32770"}, netbeans : {exe : "netbeans.exe", class : "SunAwtFrame"}}				
	}
}

