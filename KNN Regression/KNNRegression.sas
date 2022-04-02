*------------------------------------------------------------*;
* MBR: Create decision matrix;
*------------------------------------------------------------*;
data WORK.bmi(label="bmi");
  length   bmi                                  8
           ;

 bmi=16;
output;
 bmi=53.1;
output;
 bmi=30.8575700934579;
output;
;
run;
proc datasets lib=work nolist;
modify bmi(type=PROFIT label=bmi);
run;
quit;
%macro EM_MBR;
%let _MBRTRAIN = EMSCORE.EM_TRAIN_MBR;
%if %symexist(em_train) %then %do;
%let _MBRTRAIN = EMWS1.Part_TRAIN;
%end;
*------------------------------------------------------------* ;
* MBR: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* MBR: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    age bmi children expenses
%mend DMDBVar;
*------------------------------------------------------------*;
* MBR: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=&_MBRTRAIN
dmdbcat=WORK.MBR_DMDB
maxlevel = 513
;
id
_dataobs_
;
var %DMDBVar;
target
bmi
;
run;
quit;
*------------------------------------------------------------* ;
* MBR: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    age children expenses
%mend pmbrvar;
%let _vvnoption = %sysfunc(getoption(VALIDVARNAME));
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data em_MBR;
set &em_score_output;
run;
data &em_score_output;
set &em_score_output;
keep %pmbrvar;
run;
%end;
options validvarname=V7;
%if ^%symexist(em_train) %then %do;
proc pmbr data=&_MBRTRAIN dmdbcat=WORK.MBR_DMDB %end;
%else %do;
proc pmbr data=EMWS1.Part_TRAIN dmdbcat=WORK.MBR_DMDB %end;
k = 7
epsilon = 0
buckets = 8
method = SCAN
weighted
neighbors
;
var %pmbrvar;
target bmi;
score data=&em_score_output out=&em_score_output role=score;
;
id _dataobs_;
run;
quit;
options validvarname=&_vvnoption;
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data &em_score_output;
merge em_MBR &em_score_output;
run;
proc delete data=em_MBR;
run;
%end;
%mend EM_MBR;
%EM_MBR;
