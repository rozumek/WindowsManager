;================================================================
/**
 * Funkcja wyświetlająca komentarz użytkownika
 */
PrintPwcAdditionalInfoComment(username) {
	IfWinActive, PWC - 
	{	
		Send {ENTER}		
		Send DBR: %username% [%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%] {Enter}
		Send `======================================= {Enter}
		Send {ENTER}		
		Send {ENTER}
		Send {ENTER}
		Send `======================================= {Enter}
	} else {
		MsgBox Nieprawidłowe okno zgłoszenia
	}
}