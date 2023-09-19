capture program drop take_log
program define take_log
	syntax namelist(min=1 max=1), [path(string)]

	tempname date time_stamp path_log
	_get_time_stamp
	local `date' "`r(Date)'"
	local `time_stamp' "`r(TimeStamp)'"
	
	tempname path_log
	if "`path'" != "" {
		local `path_log' "`path'/``date''"
	}
	else if "${path_log}" != "" {
		local `path_log' "${path_log}/``date''"
	}
	else {
		display as error "path is not specified"
		exit, 198
	}

	capture mkdir "``path_log''"
	capture log close `namelist'

	log using "``path_log''/`namelist'_``time_stamp''.smcl", ///
		replace name(`namelist')
end

capture program drop _get_time_stamp
program define _get_time_stamp, rclass
	tempname d t date time tstamp
	
	local `d' = td(`c(current_date)')
	local `t' = tc(`c(current_time)')
	
	local `date' = string(year(``d'')) + string(month(``d''), "%02.0f") ///
		+ string(day(``d''), "%02.0f")
	local `time' = string(hh(``t''), "%02.0f") + string(mm(``t''), "%02.0f") ///
		+ string(ss(``t''), "%02.0f")
	local `tstamp' = "``date''" + "_" + "``time''"
	
	return local Date ``date''
	return local Time ``time''
	return local TimeStamp ``tstamp''
end
