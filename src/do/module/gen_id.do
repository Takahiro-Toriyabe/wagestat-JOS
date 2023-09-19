// Generate ID variable from several numeric variables
capture program drop gen_id
program define gen_id
	syntax varlist(min=1 numeric) [if], gen(name)
	marksample touse
	
	// Raise error in case of name conflict
	capture confirm variable `gen'
	if !_rc {
		gen `gen' = .
	}
	
	tempvar id
	qui gen `id' = "" if `touse'
	foreach var of varlist `varlist' {
		assert !missing(`var')
		
		tempname fmt
		_get_fmt `var' if `touse'
		qui replace `id' = `id' + strofreal(`var', "`r(fmt)'") if `touse'
	}

	qui destring `id', gen(`gen')
	capture confirm variable `gen'
	if _rc {
		gen check1 = `id'
		destring check1, gen(check2) force
		exit 198
	}
	assert !missing(`gen') if `touse'
end

// Get (minimum) format of numeric variable
capture program drop _get_fmt
program define _get_fmt, rclass
	syntax varlist(min=1 max=1 numeric) [if]
	
	marksample touse
	tempname len fmt
	
	// Confirm the variable takes non-negative integer
	assert `varlist' >= 0 if `touse'
	_confirm_int `varlist' if `touse'
	
	// Get format
	qui sum `varlist' if `touse'
	local `len' = strlen(strofreal(r(max)))
	local `fmt' = "%0``len''.0f"
	
	return local fmt = "``fmt''"
end

// Confirm the variable contains only integer
capture program drop _confirm_int
program define _confirm_int
	syntax varlist(min=1 max=1 numeric) [if]
	
	marksample touse
	tempname flag_int
	
	local `flag_int' = 0
	foreach type in byte int long {
		capture confirm `type' variable `varlist'
		local `flag_int' = ``flag_int'' | _rc == 0
	}
	if !``flag_int'' {
		display as error "ValueError: Integer is expected"
		exit 198
	}
end
