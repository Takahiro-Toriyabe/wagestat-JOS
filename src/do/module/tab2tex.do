capture program drop tab2tex
program define tab2tex
	syntax varlist(min=2 max=2) [aweight] [if] [in], ///
		using(string) row_title(string) col_title(string) ///
		[valuelabels] [row] [col] [nofreq] [format(string)]
	
	marksample touse, strok
	tempname rowvar colvar MATCELL MATROW MATCOL hh nrows ncols val lbl N N_SUB n
	
	tab `varlist' [`weight'`exp'] if `touse', `col' `row' `nofreq' ///
		matcell(`MATCELL') matrow(`MATROW') matcol(`MATCOL')
	
	local `rowvar': word 1 of `varlist'
	local `colvar': word 2 of `varlist'

	local `nrows' = rowsof(`MATCELL')
	local `ncols' = colsof(`MATCELL')
	
	// Frequency or fraction
	if "`row'" == "" & "`col'" == "" {
		matrix `N' = J(``nrows'', ``ncols'', 1)
	}
	else if "`row'" != "" {
		matrix `N_SUB' = `MATCELL' * J(``ncols'', 1, 1)
		forvalues j = 1(1)``ncols'' {
			matrix `N' = nullmat(`N'), `N_SUB'
		}
	}
	else if "`col'" != "" {
		matrix `N_SUB' = J(1, ``nrows'', 1) * `MATCELL'
		forvalues j = 1(1)``nrows'' {
			matrix `N' = nullmat(`N') \ `N_SUB'
		}
	}
	
	file open `hh' using "`using'", write replace
	
	// Write header
	file write `hh' "\toprule" _newline
	file write `hh' "\toprule" _newline

	file write `hh' "`row_title' & \multicolumn{``ncols''}{c}{`col_title'}"
	if "`row'" != "" {
			file write `hh' " & 観測数"
	}
	file write `hh' " \\" _newline
	
	forvalues j = 1(1)``ncols'' {
		if "`valuelabels'" == "" {
			local `lbl' = `MATCOL'[1, `j']
		}
		else {
			local `lbl': label `:value label ``colvar''' `=`MATCOL'[1, `j']'
			local `lbl' = subinstr("``lbl''", "~", "--", .)
		}
		file write `hh' " & ``lbl''"
	}
	file write `hh' " \\" _newline
	file write `hh' "\midrule" _newline
	
	// Write main part
	forvalues i = 1(1)``nrows'' {
		if "`valuelabels'" == "" {
			local `lbl' = `MATROW'[`i', 1]
		}
		else {
			local `lbl': label `:value label ``rowvar''' `=`MATROW'[`i', 1]'
			local `lbl' = subinstr("``lbl''", "~", "--", .)
		}
		file write `hh' "``lbl''"
		forvalues j = 1(1)``ncols'' {
			local `val' = `MATCELL'[`i', `j'] / `N'[`i', `j']
			if "`format'" != "" {
				local `val' = strofreal(``val'', "`format'")
			}
			file write `hh' " & ``val''"
		}
		if "`row'" != "" {
			local `n' = `N_SUB'[`i', 1]
			file write `hh' " & ``n''"
		}
		file write `hh' " \\" _newline
	}
	
	// Number of records in each column
	if "`col'" != "" {
		file write `hh' "観測数"
		forvalues j = 1(1)``ncols'' {
			local `n' = `N_SUB'[1, `j']
			file write `hh' " & ``n''"
		}
		file write `hh' " \\" _newline
	}

	file write `hh' "\bottomrule" _newline
	file write `hh' "\bottomrule" _newline
	file close `hh'
end
