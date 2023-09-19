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
    Date: 2021/02/17 14:32:30
-----------------------------------------------------------------------------*/



clear all
set more off
capture log close _all

global DoFilePathTemp = "${path_do}/import/ESS/"
global DataFilePathTemp = "${path_data}/chosa/ESS"

capture mkdir "${DoFilePathTemp}/log"
log using "${DoFilePathTemp}/log/log.smcl", replace

tempvar data

local dir_list: dir "${DoFilePathTemp}/" dirs "*", respectcase
foreach d in `dir_list' {
	clear
	if "`d'" != "log" {
		run "${DoFilePathTemp}/`d'/`d'_const.do"
		run "${DoFilePathTemp}/`d'/`d'_var.do"
		destring *, replace ignore("V" "*" "\")
		run "${DoFilePathTemp}/`d'/`d'_val.do"
		save "${DataFilePathTemp}/ess_`d'.dta", replace
	}
}

macro drop DoFilePathTemp
macro drop DataFilePathTemp
log close
