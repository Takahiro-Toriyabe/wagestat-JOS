capture program drop decompose_wage_change
program define decompose_wage_change, rclass
	syntax varlist(min=1 max=1 numeric) [aw/] [if], ///
		year(varname) baseyear(integer) ///
		[cellvar(varlist min=1)] [cellid(varname)]
	
	marksample touse
	tempvar pop pop_tot nobs t share grand_mean
	tempname ylist tlist W0 x1 x2 x3 RESULT

	preserve
		// Aggregate the data
		qui keep if `touse'
		foreach var in `varlist' `cellvar' `year' {
			qui drop if missing(`var')
		}
		if "`cellid'" == "" {
			tempvar cellid
			qui egen `cellid' = group(`cellvar')
		}
		
		qui levelsof `year', local(`ylist')
		qui gen `pop' = `exp'
		qui gen `nobs' = 1
		collapse (rawsum) `pop' `nobs' (mean) `varlist' [`weight'=`exp'], ///
			by(`year' `cellid')
		sum `nobs', detail

		sort `cellid' `year'
		qui by `cellid': gen `t' = _n
		qui xtset `cellid' `t'
		
		// Check if the data is balanced panel
		by `cellid': assert _N == wordcount("``ylist''")

		egen `pop_tot' = sum(`pop'), by(`t')
		gen `share' = `pop' / `pop_tot'
		egen `grand_mean' = sum(`share' * `varlist'), by(`year')

		// Modify time index t so that base year takes 0
		qui levelsof `t' if float(`year') == float(`baseyear'), local(`t0')
		qui replace `t' = 0 if float(`year') == float(`baseyear')
		qui replace `t' = `t' - 1 if `year' > `baseyear'
		
		qui xtset `cellid' `t'
		sum `grand_mean' if `t' == 0, meanonly
		local `W0' = r(mean)
		
		// Decompose wage change
		qui levelsof `t', local(`tlist')
		
		foreach s in ``tlist'' {
			if `s' == 0 {
				continue
			}

			tempname W`s' LHS`s' RHS`s'

			// LHS
			sum `grand_mean' if `t' == `s', meanonly			
			local `W`s'' = r(mean)
			local `LHS`s'' = (``W`s''' - ``W0'') / ``W0''

			// RHS: 1st term
			tempvar dw1_num dw2_num dw3_num

			qui egen `dw1_num' = sum((`share' - l`s'.`share') * l`s'.`varlist') if `t' == `s'
			sum `dw1_num' if `t' == `s', meanonly
			local `x1' = r(mean) / ``W0''

			// RHS: 2nd term
			qui egen `dw2_num' = sum(l`s'.`share' * (`varlist' - l`s'.`varlist')) if `t' == `s'
			sum `dw2_num' if `t' == `s', meanonly
			local `x2' = r(mean) / ``W0''

			// RHS: 3rd term
			qui egen `dw3_num' = sum((`share' - l`s'.`share')  * (`varlist' - l`s'.`varlist'))  if `t' == `s'
			sum `dw3_num' if `t' == `s', meanonly
			local `x3' = r(mean) / ``W0''

			local `RHS`s'' = ``x1'' + ``x2'' + ``x3''
			assert inrange(``LHS`s''' - ``RHS`s''', -1.0e-8, 1.0e-8) 
			
			matrix `RESULT' = nullmat(`RESULT'), [``LHS`s''' \ ``x1'' \ ``x2'' \ ``x3'']
		}
	restore
	
	matrix rownames `RESULT' = "Total" "Share" "Laspeyres" "Correlation"

	return scalar base = `baseyear'
	return scalar wage0 = ``W0''
	return matrix result = `RESULT'
end

capture program drop decompose_wage_change_rotate
program define decompose_wage_change_rotate, rclass
	syntax varlist(min=1 max=1 numeric) [aw] [if], ///
		year(varname) cellid(varname)
		
	marksample touse
	tempname ylist Y s t RESULT_TEMP RESULT W0 W0_TEMP SHARE

	qui levelsof `year' if `touse', local(`ylist') 
	local `Y' = wordcount("``ylist''") - 1

	forvalues i = 1(1)``Y'' {
		local `s': word `i' of ``ylist''
		local `t': word `=`i'+1' of ``ylist''

		qui decompose_wage_change `varlist' [`weight'`exp'] ///
			if `touse' & inlist(`year', ``s'', ``t''), ///
			cellid(`cellid') year(`year') baseyear(``s'')
		
		// Collect calculation result
		matrix `RESULT_TEMP' = r(result)
		matrix colnames `RESULT_TEMP' = "``s''-``t''"
		matrix `RESULT' = nullmat(`RESULT'), `RESULT_TEMP'
		
		matrix `W0_TEMP' = [r(wage0)]
		matrix `W0' = nullmat(`W0'), `W0_TEMP'
	}
	matrix `RESULT' = `RESULT' \ `W0'
	matrix rownames `RESULT' = "Total" "Share" "Laspeyres" "Correlation" "Base mean"
	
	// Calculate composition of each term relative to total change
	matrix `SHARE' = J(3, ``Y'', .)
	forvalues j = 1(1)``Y'' {
		forvalues i = 1(1)3 {
			matrix `SHARE'[`i', `j'] = `RESULT'[`i' + 1, `j'] / abs(`RESULT'[1, `j'])
		}
	}
	
	matlist `RESULT'

	return matrix result = `RESULT'
	return matrix share = `SHARE'
end
