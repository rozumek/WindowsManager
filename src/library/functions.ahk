;================================================================
/**
 * Funkcja wyświetlająca komentarz użytkownika
 */
PrintPwcAdditionalInfoComment(username) {
	IfWinActive, PWC - 
	{
		Send {ENTER}		
		Send DBR: %username% [%A_YYYY%-%A_MM%-%A_DD%] ======================== {Enter}
		Send {ENTER}		
	} else {
		MsgBox Nieprawidłowe okno zgłoszenia
	}
}