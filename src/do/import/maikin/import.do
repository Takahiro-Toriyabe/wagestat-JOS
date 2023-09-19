/*-----------------------------------------------------------------------------
    <README>
    This do-file is generated from the python program provided
    in 'https://github.com/Takahiro-Toriyabe/MicroDataCleaning'.
        _const.do:    Import fixed-length data
        _var.do:      Put variable labels
        _val.do:      Put value labels
        _validate.do: Check if the data seems correctly imported
        rename.do:    Rename variable to harmonize several data

    WARNING:
        1. The generated do-files do not necessarily correct. If you find
           something wrong regarding the program or the resulting do-file(s),
           please report at the above GitHub web page.

        2. _validate.do checks if each variable has the values that it is
           supposed to have (only for categorical variables).

        3. rename.do is generated by finding a variable with a similar variable
           description and, if any, a similar variable name from the base data.
           So it is quite likely that some variables are renamed incorrectly.
           Please check and modify rename.do.

        4. Although value labels are put for each individual data, the labels
           are not put for the appended data, because the categories for each
           variable are very likely to be inconsistent across years.

        5. There is no file to make variable values consistent across different
           data.


    Source: 
    Date: 2020/08/11 21:22:30
-----------------------------------------------------------------------------*/

capture log close _all

global DoFilePathTemp = "${path_import}/maikin"
global DataFilePathTemp = "${path_chosa_maikin}"

capture mkdir "${DoFilePathTemp}/log"
log using "${DoFilePathTemp}/log/log.smcl", replace

forvalues y = 25(1)29 {
	clear
	run "${DoFilePathTemp}/h`y'/h`y'_const.do"
	run "${DoFilePathTemp}/h`y'/h`y'_var.do"
	save "${DataFilePathTemp}/maikin_h`y'_str.dta", replace
	destring *, replace
	run "${DoFilePathTemp}/h`y'/h`y'_val.do"
	run "${DoFilePathTemp}/h`y'/h`y'_validate.do"
	save "${DataFilePathTemp}/maikin_h`y'.dta", replace
}

clear
append using ///
    "${DataFilePathTemp}/maikin_h25_str.dta" ///
    "${DataFilePathTemp}/maikin_h26_str.dta" ///
    "${DataFilePathTemp}/maikin_h27_str.dta" ///
    "${DataFilePathTemp}/maikin_h28_str.dta" ///
    "${DataFilePathTemp}/maikin_h29_str.dta" ///
    , gen(flag_tmp_NEWVARIABLE)

run "${DoFilePathTemp}/rename.do"
destring *, replace
drop flag_tmp
capture drop *_ToBeDropped

do "${DoFilePathTemp}/clean.do"

save "${DataFilePathTemp}/maikin.dta", replace

macro drop DoFilePathTemp
macro drop DataFilePathTemp
log close

