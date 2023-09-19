// Largest variable number (subtract 1 as the number start from 0)
local k = c(k) - 1

// Make Census key
gen var0 = v0 + v1 + v2 + v3
drop v0 v1 v2 v3

// Since 1st-4th variables are dropped, change serial number in variable name
forvalues i = 4(1)`k' {
	local j = `i' - 3
	rename v`i' var`j'
}

aorder
