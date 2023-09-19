capture program drop calc_pctile_diff
program define calc_pctile_diff, eclass
	syntax varlist(min=1 max=1 numeric) [if], ///
		percentiles(numlist) by(varname) wt(varname)
	marksample touse

	tempname glist np gval B1 B2 D colnames
	qui levelsof `by', local(`glist')
	if wordcount("``glist''") != 2 {
		display as error "Binary group indicator is expected"
		exit 198
	}

	local `np' = wordcount("`percentiles'")
	foreach i in 1 2 {
		local `gval': word `i' of ``glist''
		qui _pctile `varlist' [aw=`wt'] if `touse' & `by' == ``gval'', ///
			percentiles(`percentiles')
		forvalues j = 1(1)``np'' {
			matrix `B`i'' = nullmat(`B`i''), r(r`j')
		}
	}

	local `colnames' ""
	foreach p of numlist `percentiles' {
		local `colnames' "``colnames'' p`p'"
	}
	
	matrix `D' = `B2' - `B1'
	matrix colnames `D' = ``colnames''
	ereturn post `D', esample(`touse')
end

capture program drop bootstrap_pctile_diff
program define bootstrap_pctile_diff, eclass
	syntax varlist(min=1 max=1 numeric) [if], ///
		percentiles(numlist) by(varname) wt(varname) cluster(varlist) ///
		reps(integer) seed(integer)

	marksample touse
	bootstrap _b, reps(`reps') cluster(`cluster') seed(`seed'): ///
		calc_pctile_diff `varlist' if `touse', ///
		percentiles(`percentiles') by(`by') wt(`wt')
end
