_SCREEN.Visible = .F.
_SCREEN.Enabled = .F.
SET TALK OFF

_InfPath = FULLPATH(CURDIR())
IF FILE(_InfPath + [instfont.inf])
	IF ATC("Windows 6", OS(1)) # 0 OR ATC("Windows NT", OS(1)) # 0
		_Exec = M_Root + '/setupnt.bat'
	ELSE
		_Exec = M_Root + '/setup.bat'
	ENDIF

	_Error = 0
	_LastError = ON('ERROR')
	ON ERROR _Error = ERROR()
	RUN /N &_Exec
	ON ERROR &_LastError
ENDIF

QUIT