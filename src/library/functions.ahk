;================================================================
/**
 * Funkcja wy�wietlaj�ca komentarz u�ytkownika
 */
PrintPwcAdditionalInfoComment(username) {
	IfWinActive, PWC - 
	{
		Send {ENTER}		
		Send DBR: %username% [%A_YYYY%-%A_MM%-%A_DD%] ======================== {Enter}
		Send {ENTER}		
	} else {
		MsgBox Nieprawid�owe okno zg�oszenia
	}
}