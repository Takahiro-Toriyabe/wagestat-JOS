capture program drop export_twoway_table
program define export_twoway_table
	syntax varlist(min=2 max=2 numeric) [aweight] [if], ///
		main_var(varname) format(string) ///
		export(string) ///
		[valuelabel] ///
		[total1] [total2]
	
	marksample touse, strok

	tempname hh v1 v2 l1 l2 nrows ncols cat1 cat2 mean lbl
	file open `hh' using `export', write replace

	foreach i in 1 2 {
		local `v`i'': word `i' of `varlist'
		qui levelsof ``v`i''', local(`l`i'')
	}

	local `nrows' = wordcount("``l1''")
	local `ncols' = wordcount("``l2''")

	forvalues i = 1(1)``nrows'' {
		local `cat1': word `i' of ``l1''
		if "`valuelabel'" != "" {
			local `lbl' = subinstr("`: label `:value label ``v1''' ``cat1'''", "~", "--", .)
		}
		else {
			local `lbl' = ``cat1''
		}
		
		// Grand mean over the first variable
		if "`total1'" != "" & `i' == 1 {
			file write `hh' "全て"
			if "`total2'" != "" {
				sum `main_var' [`weight'`exp'] if  `touse', meanonly
				local `mean' = strofreal(r(mean), "`format'")
				file write `hh' " & ``mean''" 
			}
			forvalues j = 1(1)``ncols'' {
				local `cat2': word `j' of ``l2''
				sum `main_var' [`weight'`exp'] if `touse' & ``v2'' == ``cat2'', ///
					meanonly
				local `mean' = strofreal(r(mean), "`format'")
				file write `hh' " & ``mean''"
			}
			file write `hh' " \\" _newline
		}

		// Write main part
		file write `hh' "``lbl''"
		if "`total2'" != "" {
			sum `main_var' [`weight'`exp'] ///
				if  `touse' & ``v1'' == ``cat1'', meanonly
			local `mean' = strofreal(r(mean), "`format'")
			file write `hh' " & ``mean''" 
		}
		forvalues j = 1(1)``ncols'' {
			local `cat2': word `j' of ``l2''
			sum `main_var' [`weight'`exp'] ///
				if  `touse' & ``v1'' == ``cat1'' & ``v2'' == ``cat2'', ///
				meanonly
			local `mean' = strofreal(r(mean), "`format'")
			file write `hh' " & ``mean''"
		}
		file write `hh' " \\" _newline
	}
	
	file close `hh'
end
