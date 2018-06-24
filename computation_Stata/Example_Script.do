**************
*
* Set Up
*
**************

cd "/users/nick/github/poli_sci_boot_camp/"

**************
*
* Read in data
*
**************

insheet using  "exercise_data/dwnominate.csv", clear

**************
*
* Clean and Re-Organize Data
*
**************

* Just look at the data
browse

* Just want more recent years
keep if congress > 100

* Party Code is weird -- recode
tab party_code
gen democrat = party_code == 100 if (party_code == 100 | party_code == 200 | party_code == 300)


**************
*
* Basic Analysis
*
**************




**************
*
* Plots
*
**************


twoway (kdensity idealpoint_1st if democrat == 1 & congress == 121, ///
        lcolor(blue)) ///
       (kdensity idealpoint_1st if democrat == 0 & congress == 121,
        lcolor(red)) ///
