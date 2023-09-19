// Make detailed industry code
replace v9 = v9 + v10
assert strlen(v9) == 3

// Replace var10 with missing just to make it compatible with the sample record
replace v10 = ""

// v11 is empty
drop v11

// Since 11th variable is dropped, change serial number in variable name
forvalues i = 12(1)46 {
	rename v`i' var`--i'
}

// Separate v47 into main code and check digit
gen check = v47
drop v47

gen var46 = substr(check, 1, strlen(check) - 1)
gen var47 = substr(check, -1, 1)

assert strlen(var46) == strlen(check) - 1
assert strlen(var47) == 1
assert check == var46 + var47

drop check

// Rename remaining variables from vXX to varXX
rename v# var#

aorder
