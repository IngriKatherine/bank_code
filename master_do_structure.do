*** Master do-file structure 
*** @ SGNG, last update 16/12/2020
*** Ref: https://dimewiki.worldbank.org/wiki/Master_Do-files

************************************************************************************
************************************************************************************

** a. Intro header: Purpose of the do-file (outline, data files required, data files created, variable that uniquely identifies the unit of observations)

** b. Install packages required to run the code 
ssc install ietoolkit, replace 


** c. Settings (STATA version, memory, etc)
ieboilstart, version(12.1)      //Set the version number to the oldest version used by anyone in the project team
`r(version)'                    //This line is needed to actually set the version from the command above

** d. Root folder globals 
* Example
*User Number:
* Ann          1 
* John         2
* Add more users here as needed

*Set this value to the user currently using this file
global user  1

* Root folder globals
* ---------------------
if $user == 1 {
       global projectfolder "C:/Users/AnnDoe/Dropbox/Project ABC"
   }

if $user == 2 {
       global projectfolder  "C:/Users/JohnSmith/Dropbox/Project ABC"
   }

** e. Project folder globals 
* Example
global dataWorkFolder "$projectfolder/DataWork"
global baseline       "$dataWorkFolder/Baseline"
global endline        "$dataWorkFolder/Endline"

** f. Units and assumptions 
** If using iefolder, a separate file exists so that exact global definitions can be accessed from any both project and round master do-file. The global setup file is referenced as: 
do "$dataWorkFolder/global_setup.do" 

** g. Sub master do-file: A project master do-file runs the round master do-files (i.e. baseline, endline); a round master do-file runs round-specific, high-level task master do-files (i.e. import, cleaning, analysis); and the round-specific, high-level task master do-file runs the do-files that complete the parts of each high-level task.
* In iefolder, a round master do-file would look like this:
local importDo       0
local cleaningDo     0

 if (`importDo' == 1) { //Change the local above to run or not to run this file
       do "$baseline_doImp/baseline_import_MasterDofile.do" 
   }
   if (`cleaningDo' == 1) { //Change the local above to run or not to run this file
       do "$baseline_do/baseline_cleaning_MasterDofile.do" 
   }
   
   
************************************************************************************
** Tempfiles: These files are created to avoid creating alot of intermediate files 
** Use the commands below to create them 
************************************************************************************
tempfile name 
save `name', replace

use `name', clear

************************************************************************************
** Logfiles : These files normally are used in do-files that performed specific tasks
** i.e. cleaning, db creation, labelling, etc
** Note: Rem. that sysdate is a local date variable created in the master-do file
************************************************************************************
global sysdate = c(current_date)

cap log close
set more off
cd $path
log using "$sysdate.smcl", replace 







