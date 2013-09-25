;================================================================
/**
 * Funkcja wyœwietlaj¹ca komentarz u¿ytkownika
 */
PrintPwcAdditionalInfoComment(username) {
	IfWinActive, PWC - 
	{
		Send {ENTER}		
		Send DBR: %username% [%A_YYYY%-%A_MM%-%A_DD%] ======================== {Enter}
		Send {ENTER}		
	} else {
		MsgBox Nieprawid³owe okno zg³oszenia
	}
}