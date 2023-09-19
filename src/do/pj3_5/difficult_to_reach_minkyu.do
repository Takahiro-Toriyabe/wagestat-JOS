// Data construction
use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 KYOKUSYO SEIRI year ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3) gen(merge_result)
merge m:1 KYOKUSYO SEIRI year ///
	using "${path_root}/data/est_info_minkyu.dta", ///
	assert(3) nogen

isid KYOKUSYO SEIRI year
egen id_tmp = group(KYOKUSYO SEIRI)
sort id_tmp year
by id_tmp: gen t_tmp = _n
assert inrange(t_tmp, 1, 8)

// Count # of sampled years and responses
gen flag_sampled = !missing(merge_result)
gen flag_respond = merge_result == 3

by id_tmp: egen nsampled = total(flag_sampled)
by id_tmp: egen nrespond = total(flag_respond)

tempfile tmp
keep id_tmp KYOKUSYO SEIRI year estsize industry nrespond nsampled 
save `tmp'

// Merge response history
use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)
merge m:1 KYOKUSYO SEIRI year using `tmp', keep(3) nogen 

gen earnings = KYUYOGAKU_KEI / 1000 / cpi
gen ln_earnings = ln(earnings)

keep if nsampled > 1

forvalues j = 2(1)8 {
	reghdfe ln_earnings ib`j'.nrespond [aw=${weight_minkyu_k}] ///
		if nsampled == `j', absorb(year estsize industry) cluster(id_tmp)
	local n`j' = e(N)
	forvalues i = 1(1)`j' {
		local b`i'`j' = strofreal(_b[`i'.nrespond], "%04.3f")
		if `i' < `j' {
			local se`i'`j' = "(" + strofreal(_se[`i'.nrespond], "%04.3f") + ")"
		}
		qui count if e(sample) & nrespond == `i'
		local n`i'`j' = r(N)
		local share`i'`j' = strofreal(100 * `n`i'`j'' / `n`j'', "%03.1f") + "\%"
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_5/difficult_to_reach_minkyu.tex", write replace

file write `hh' "\#Response=1 & `b12' & `share12' & `b13' & `share13' & `b14' & `share14' & `b15' & `share15' & `b16' & `share16' & `b17' & `share17' & `b18' & `share18' \\" _newline
file write `hh' "& `se12' & & `se13' & & `se14' & & `se15' & &`se16' & & `se17' & &`se18' & \\" _newline
file write `hh' "\#Response=2 & `b22' & `share22' & `b23' & `share23' & `b24' & `share24' & `b25' & `share25' & `b26' & `share26' & `b27' & `share27' & `b28' & `share28' \\" _newline
file write `hh' "& `se22' & & `se23' & & `se24' & & `se25' & &`se26' && `se27' & &`se28' &  \\" _newline
file write `hh' "\#Response=3 & `b32' & `share32' & `b33' & `share33' & `b34' & `share34' & `b35' & `share35' & `b36' & `share36' & `b37' & `share37' & `b38' & `share38' \\" _newline
file write `hh' "& `se32' & & `se33' & & `se34' & & `se35' & &`se36' && `se37' & &`se38' &  \\" _newline
file write `hh' "\#Response=4 & `b42' & `share42' & `b43' & `share43' & `b44' & `share44' & `b45' & `share45' & `b46' & `share46' & `b47' & `share47' & `b48' & `share48' \\" _newline
file write `hh' "& `se42' & & `se43' & & `se44' & & `se45' & &`se46' & & `se47' & &`se48' & \\" _newline
file write `hh' "\#Response=5 & `b52' & `share52' & `b53' & `share53' & `b54' & `share54' & `b55' & `share55' & `b56' & `share56' & `b57' & `share57' & `b58' & `share58' \\" _newline
file write `hh' "& `se52' & & `se53' & & `se54' & & `se55' & &`se56' & & `se57' & &`se58' & \\" _newline
file write `hh' "\#Response=6 & `b62' & `share62' & `b63' & `share63' & `b64' & `share64' & `b65' & `share65' & `b66' & `share66' & `b67' & `share67' & `b68' & `share68' \\" _newline
file write `hh' "& `se62' & & `se63' & & `se64' & & `se65' & &`se66' & & `se67' & &`se68' & \\" _newline
file write `hh' "\#Response=7 & `b72' & `share72' & `b73' & `share73' & `b74' & `share74' & `b75' & `share75' & `b76' & `share76' & `b77' & `share77' & `b78' & `share78' \\" _newline
file write `hh' "& `se72' & & `se73' & & `se74' & & `se75' & &`se76' & & `se77' & &`se78' & \\" _newline
file write `hh' "\#Response=8 & `b82' & `share82' & `b83' & `share83' & `b84' & `share84' & `b85' & `share85' & `b86' & `share86' & `b87' & `share87' & `b88' & `share88' \\" _newline
file write `hh' "& `se82' & & `se83' & & `se84' & & `se85' & &`se86' & & `se87' & &`se88' & \\" _newline
file write `hh' "Observations & `n2' & & `n3' & & `n4' & & `n5' & & `n6' & & `n7' & & `n8' & \\" _newline
file close `hh'
