foreach d in `: dir "${path_do}/import/" dirs "*", respectcase' {
	capture confirm file "${path_do}/import/`d'/import.do"
	if !_rc {
		do "${path_do}/import/`d'/import.do"
	}
}
