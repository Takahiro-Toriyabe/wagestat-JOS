capture program drop _encoding_sjis
program define _encoding_sjis
	syntax anything
	
	clear
	shell rm -r "bak.stunicode"
	unicode encoding set "Shift_JIS"
	unicode translate "`anything'"
end

local pwd "`c(pwd)'"
cd "${path_meibo_chingin}"

forvalues y = 21(1)24 {
	run "${path_import}/chingin_meibo/h`y'/h`y'_const.do"
	run "${path_import}/chingin_meibo/h`y'/h`y'_var.do"
	save "${path_meibo_chingin}/chingin_meibo_h`y'.dta", replace
	
	_encoding_sjis chingin_meibo_h`y'.dta
}

forvalues y = 25(1)28 {
	run "${path_import}/chingin_meibo/h`y'/h`y'_const.do"
	save "${path_meibo_chingin}/chingin_meibo_h`y'.dta", replace
	
	_encoding_sjis chingin_meibo_h`y'.dta

	use "${path_meibo_chingin}/chingin_meibo_h`y'.dta", clear
	run "${path_import}/chingin_meibo/h`y'/h`y'_rename1.do"
	run "${path_import}/chingin_meibo/h`y'/h`y'_rename2.do"
	save "${path_meibo_chingin}/chingin_meibo_h`y'.dta", replace
}

run "${path_import}/chingin_meibo/h29/h29_const.do"

cd "`pwd'"
