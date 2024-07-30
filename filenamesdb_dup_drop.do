clear all
global dirpath "C:\Users\ingriq\Downloads\"
local dropifduplicated csv

local myfiles : dir "${dirpath}\" files "*" 
local i=0
foreach file in `myfiles' {
	local ++i
}
display "`i'"
set obs `i'

gen file_name=""
gen i=_n

local i=0
foreach file in `myfiles' {
	local ++i
	replace file_name="`file'" if i==`i'
}

replace file_name=lower(file)
split file_name, p(".")
drop file_name 
rename file_name2 file_extension

rename file_name1 file_name
keep file_name file_extension
tab file_extension

duplicates tag file_name, gen(to_drop)
replace to_drop=1 if to_drop==1 & file_extension=="`dropifduplicated'"
drop if to_drop==1
drop to_drop

drop file_name file_extension

export excel using "${dirpath}\files_list.xlsx", firstrow(variables) replace