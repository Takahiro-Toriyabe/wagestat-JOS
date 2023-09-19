// Wage Census
do "${path_do}/pj3_5/transition_matrix_chingin.do"

foreach var in year estsize industry Ken popcat {
	drop if missing(`var')
}

reg flag_resp ib1.resptype1, cluster(id_common)
local b1 = strofreal(_b[2.resptype1], "%04.3f")
local s1 = "(" + strofreal(_se[2.resptype1], "%04.3f") + ")"
local b1_cons = strofreal(_b[_cons], "%04.3f")
local s1_cons =  "(" + strofreal(_se[_cons], "%04.3f") + ")"
local n1 = e(N)

reghdfe flag_resp ib1.resptype1, ///
	absorb(year estsize industry Ken popcat) cluster(id_common)
local b2 = strofreal(_b[2.resptype1], "%04.3f")
local s2 = "(" + strofreal(_se[2.resptype1], "%04.3f") + ")"
local n2 = e(N)

reg flag_resp ib1.resptype2, cluster(id_common)
local b3_1 = strofreal(_b[2.resptype2], "%04.3f")
local s3_1 = "(" + strofreal(_se[2.resptype2], "%04.3f") +")"
local b3_2 = strofreal(_b[3.resptype2], "%04.3f")
local s3_2 = "(" + strofreal(_se[3.resptype2], "%04.3f") + ")"
local b3_3 = strofreal(_b[4.resptype2], "%04.3f")
local s3_3 = "(" + strofreal(_se[4.resptype2], "%04.3f") + ")"
local b3_cons = strofreal(_b[_cons], "%04.3f")
local s3_cons = "(" + strofreal(_se[_cons], "%04.3f") + ")"
local n3 = e(N)

reghdfe flag_resp ib1.resptype2, ///
	absorb(year estsize industry Ken popcat) cluster(id_common)
local b4_1 = strofreal(_b[2.resptype2], "%04.3f")
local s4_1 = "(" + strofreal(_se[2.resptype2], "%04.3f") + ")"
local b4_2 = strofreal(_b[3.resptype2], "%04.3f")
local s4_2 = "(" + strofreal(_se[3.resptype2], "%04.3f") + ")"
local b4_3 = strofreal(_b[4.resptype2], "%04.3f")
local s4_3 = "(" + strofreal(_se[4.resptype2], "%04.3f") + ")"
local n4 = e(N)

// Minkyu
do "${path_do}/pj3_5/transition_matrix_minkyu.do"

foreach var in year estsize industry {
	drop if missing(`var')
}

reg flag_resp ib1.resptype1, cluster(id)
local b5 = strofreal(_b[2.resptype1], "%04.3f")
local s5 = "(" + strofreal(_se[2.resptype1], "%04.3f") + ")"
local b5_cons = strofreal(_b[_cons], "%04.3f")
local s5_cons = "(" + strofreal(_se[_cons], "%04.3f") + ")"
local n5 = e(N)

reghdfe flag_resp ib1.resptype1, ///
	absorb(year estsize industry) cluster(id)
local b6 = strofreal(_b[2.resptype1], "%04.3f")
local s6 = "(" + strofreal(_se[2.resptype1], "%04.3f") + ")"
local n6 = e(N)

reg flag_resp ib1.resptype2, cluster(id)
local b7_1 = strofreal(_b[2.resptype2], "%04.3f")
local s7_1 = "(" + strofreal(_se[2.resptype2], "%04.3f") +")"
local b7_2 = strofreal(_b[3.resptype2], "%04.3f")
local s7_2 = "(" + strofreal(_se[3.resptype2], "%04.3f") + ")"
local b7_3 = strofreal(_b[4.resptype2], "%04.3f")
local s7_3 = "(" + strofreal(_se[4.resptype2], "%04.3f") + ")"
local b7_cons = strofreal(_b[_cons], "%04.3f")
local s7_cons = "(" + strofreal(_se[_cons], "%04.3f") + ")"
local n7 = e(N)

reghdfe flag_resp ib1.resptype2, ///
	absorb(year estsize industry) cluster(id)
local b8_1 = strofreal(_b[2.resptype2], "%04.3f")
local s8_1 = "(" + strofreal(_se[2.resptype2], "%04.3f") + ")"
local b8_2 = strofreal(_b[3.resptype2], "%04.3f")
local s8_2 = "(" + strofreal(_se[3.resptype2], "%04.3f") + ")"
local b8_3 = strofreal(_b[4.resptype2], "%04.3f")
local s8_3 = "(" + strofreal(_se[4.resptype2], "%04.3f") + ")"
local n8 = e(N)

// Export regression result
tempname hh
file open `hh' using "${path_table}/pj3_5/reg_transition.tex", write replace

file write `hh' "NR & `b1' & `b2' & & & `b5' & `b6' & & \\" _newline
file write `hh' "& `s1' & `s2' & & & `s5' & `s6' & & \\" _newline

file write `hh' "NR \textrightarrow R & & & `b3_1' & `b4_1' & & & `b7_1' & `b8_1' \\" _newline
file write `hh' "& & & `s3_1' & `s4_1' & & & `s7_1' & `s8_1' \\" _newline

file write `hh' "R \textrightarrow NR & & & `b3_2' & `b4_2' & & & `b7_2' & `b8_2' \\" _newline
file write `hh' "& & & `s3_2' & `s4_2' & & & `s7_2' & `s8_2' \\" _newline

file write `hh' "NR \textrightarrow NR & & & `b3_3' & `b4_3' & & & `b7_3' & `b8_3' \\" _newline
file write `hh' "& & & `s3_3' & `s4_3' & & & `s7_3' & `s8_3' \\" _newline

file write `hh' "Constant & `b1_cons' & & `b3_cons' & & `b5_cons' & & `b7_cons' & \\" _newline
file write `hh' "& `s1_cons' & & `s3_cons' & & `s5_cons' & & `s7_cons' & \\" _newline

file write `hh' "Controls & & X & & X & & X & & X \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' & `n6' & `n7' & `n8' \\" _newline

file close `hh'
