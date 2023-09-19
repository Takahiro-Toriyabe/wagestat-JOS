capture program drop make_city_cat
program define make_city_cat
	syntax anything [if], pref(varname) city(varname)
	
	marksample touse
	
	tempvar jiscode
	qui gen `jiscode' = 1000 * `pref' + `city'
	qui gen `anything' = .
	
	// SEIREI-SHITEI-TOSHI & TOKUBETSUKU
	qui replace `anything' = 1 if `touse' & inrange(`city', 100, 199)
	
	// CHUKAKUSHI
	qui replace `anything' = 2 if `touse' & inlist(`jiscode', ///
		1204, ///
		1202, ///
		2202, ///
		2203, ///
		3201, ///
		5201, ///
		6201, ///
		7203, ///
		7204, ///
		7201, ///
		8201, ///
		9201, ///
		10201, ///
		10202, ///
		11201, ///
		11222, ///
		11203, ///
		12204, ///
		12217, ///
		13201, ///
		14201, ///
		16201, ///
		17201, ///
		18201, ///
		19201, ///
		20201, ///
		21201, ///
		23211, ///
		23201, ///
		23202, ///
		25201, ///
		27207, ///
		27227, ///
		27203, ///
		27210, ///
		27212, ///
		27215, ///
		27205, ///
		28201, ///
		28204, ///
		28202, ///
		28203, ///
		29201, ///
		30201, ///
		31201, ///
		32201, ///
		33202, ///
		34207, ///
		34202, ///
		35201, ///
		37201, ///
		38201, ///
		39201, ///
		40203, ///
		42201, ///
		42202, ///
		44201, ///
		45201, ///
		46201, ///
		47201 ///
	)

	// OTHER CITY
	qui replace `anything' = 3 if `touse' & missing(`anything') & inrange(`city', 200, 299)
	
	// CHO-SON
	qui replace `anything' = 4 if `touse' & missing(`anything') & !missing(`city')
	
	// Put value label
	capture label drop `anything'
	label define `anything' 1 "政令指定都市" 2 "中核市" 3 "その他の市" 4 "町村"
	label values `anything' `anything'
end
