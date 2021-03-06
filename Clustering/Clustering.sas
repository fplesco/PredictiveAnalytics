*------------------------------------------------------------*;
* EM Version: 15.1;
* SAS Release: 9.04.01M6P110718;
* Host: odaws01-usw2.oda.sas.com;
* Project Path: ~;
* Project Name: K-Means;
* Diagram Id: EMWS1;
* Diagram Name: Clustering;
* Generated by: u59400693;
* Date: 02APR2022:18:30:11;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Macro Variables;
*------------------------------------------------------------*;
%let EM_PROJECT =;
%let EM_PROJECTNAME =;
%let EM_WSNAME =;
%let EM_WSDESCRIPTION =Clustering;
%let EM_SUMMARY =WORK.SUMMARY;
%let EM_NUMTASKS =SINGLE;
%let EM_EDITMODE =R;
%let EM_DEBUGVAL =;
%let EM_ACTION =run report;
*------------------------------------------------------------*;
%macro em_usedatatable;
%if ^%symexist(EM_USEDATATABLE) %then %do;
%let EM_USEDATATABLE = Y;
%end;
%if "&EM_USEDATATABLE" ne "N" %then %do;
*------------------------------------------------------------*;
* Data Tables;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
%end;
%mend em_usedatatable;
%em_usedatatable;
*------------------------------------------------------------*;
* Create workspace data set;
*------------------------------------------------------------*;
data workspace;
length property $64 value $200;
property= 'PROJECTLOCATION';
value= "&EM_PROJECT";
output;
property= 'PROJECTNAME';
value= "&EM_PROJECTNAME";
output;
property= 'WORKSPACENAME';
value= "&EM_WSNAME";
output;
property= 'WORKSPACEDESCRIPTION';
value= "&EM_WSDESCRIPTION";
output;
property= 'SUMMARYDATASET';
value= "&EM_SUMMARY";
output;
property= 'NUMTASKS';
value= "&EM_NUMTASKS";
output;
property= 'EDITMODE';
value= "&EM_EDITMODE";
output;
property= 'DEBUG';
value= "&EM_DEBUGVAL";
output;
run;
*------------------------------------------------------------*;
* Create nodes data set;
*------------------------------------------------------------*;
data nodes;
length id $12 component $32 description $64 X 8 Y 8 diagramID $32 parentID $32;
id= "FIMPORT";
component="FileImport";
description= "File Import";
diagramID="_ROOT_";
parentID="";
X=75;
Y=46;
output;
id= "Clus";
component="Cluster";
description= "Cluster";
diagramID="_ROOT_";
parentID="";
X=285;
Y=46;
output;
run;
*------------------------------------------------------------*;
* Variable Attributes for FIMPORT;
*------------------------------------------------------------*;
data WORK.FIMPORT_VariableAttribute;
length Variable $64 AttributeName $32 AttributeValue $64;
Variable='VAR1';
AttributeName="ROLE";
AttributeValue='REJECTED';
Output;
run;
*------------------------------------------------------------*;
* USERTRAINCODE File for FIMPORT;
*------------------------------------------------------------*;
data _null_;
if symget('sysscp')=:'WIN' then dsep='\';
else if symget('sysscp')=:'DNT' then dsep='\';
else dsep = '/';
filepath = pathname('work')!!dsep!!"FIMPORT_USERTRAINCODE.sas";
call symput('DSPATH', filepath);
run;
data _null_;
filename dspath "&dspath";
file dspath;
run;
*------------------------------------------------------------*;
* VARIABLESETDELTA File for FIMPORT;
*------------------------------------------------------------*;
data _null_;
if symget('sysscp')=:'WIN' then dsep='\';
else if symget('sysscp')=:'DNT' then dsep='\';
else dsep = '/';
filepath = pathname('work')!!dsep!!"FIMPORT_VARIABLESETDELTA.txt";
call symput('DSPATH', filepath);
run;
data _null_;
filename dspath "&dspath";
file dspath;
put 'if NAME="VAR1" then do;';
put 'ROLE="REJECTED";';
put 'LEVEL="INTERVAL";';
put 'ORDER="";';
put 'DROP="N";';
put 'end;';
run;
*------------------------------------------------------------*;
* DELTACODE File for FIMPORT;
*------------------------------------------------------------*;
data _null_;
if symget('sysscp')=:'WIN' then dsep='\';
else if symget('sysscp')=:'DNT' then dsep='\';
else dsep = '/';
filepath = pathname('work')!!dsep!!"FIMPORT_DELTACODE.txt";
call symput('DSPATH', filepath);
run;
data _null_;
filename dspath "&dspath";
file dspath;
put 'if NAME="VAR1" then do;';
put 'ROLE="REJECTED";';
put 'LEVEL="INTERVAL";';
put 'ORDER="";';
put 'end;';
put 'drop DROP;';
run;
*------------------------------------------------------------*;
* EMNOTES File for FIMPORT;
*------------------------------------------------------------*;
data _null_;
if symget('sysscp')=:'WIN' then dsep='\';
else if symget('sysscp')=:'DNT' then dsep='\';
else dsep = '/';
filepath = pathname('work')!!dsep!!"FIMPORT_EMNOTES.txt";
call symput('DSPATH', filepath);
run;
data _null_;
filename dspath "&dspath" encoding="utf-8" NOBOM;
file dspath;
run;
*------------------------------------------------------------*;
* EMNOTES File for Clus;
*------------------------------------------------------------*;
data _null_;
if symget('sysscp')=:'WIN' then dsep='\';
else if symget('sysscp')=:'DNT' then dsep='\';
else dsep = '/';
filepath = pathname('work')!!dsep!!"Clus_EMNOTES.txt";
call symput('DSPATH', filepath);
run;
data _null_;
filename dspath "&dspath" encoding="utf-8" NOBOM;
file dspath;
run;
*------------------------------------------------------------*;
* Create node properties data set;
*------------------------------------------------------------*;
data nodeprops;
length id $12 property $64 value $400;
id= "FIMPORT";
property="Location";
value= "CATALOG";
output;
id= "FIMPORT";
property="Catalog";
value= "SASHELP.EMSAMP.Fimport.SOURCE";
output;
id= "FIMPORT";
property="ImportType";
value= "Local";
output;
id= "FIMPORT";
property="GuessRows";
value= "500";
output;
id= "FIMPORT";
property="Delimiter";
value= ",";
output;
id= "FIMPORT";
property="NameRow";
value= "Y";
output;
id= "FIMPORT";
property="SkipRows";
value= "0";
output;
id= "FIMPORT";
property="MaxRows";
value= "1000000";
output;
id= "FIMPORT";
property="MaxCols";
value= "10000";
output;
id= "FIMPORT";
property="FileType";
value= "csv";
output;
id= "FIMPORT";
property="Role";
value= "TRAIN";
output;
id= "FIMPORT";
property="ForceRun";
value= "N";
output;
id= "FIMPORT";
property="Summarize";
value= "N";
output;
id= "FIMPORT";
property="AdvancedAdvisor";
value= "N";
output;
id= "FIMPORT";
property="RunAction";
value= "Train";
output;
id= "FIMPORT";
property="Component";
value= "FileImport";
output;
id= "FIMPORT";
property="IFileName";
value= "C:\Users\fples\Documents\GitHub\PredictiveAnalytics\K-Means\iris.csv";
output;
id= "FIMPORT";
property="AccessTable";
value= "NoTableName";
output;
id= "FIMPORT";
property="UserID";
value= "NoUserID";
output;
id= "FIMPORT";
property="Password";
value= "NoPassword";
output;
id= "FIMPORT";
property="ToolType";
value= "SAMPLE";
output;
id= "FIMPORT";
property="ToolPrefix";
value= "FIMPORT";
output;
id= "FIMPORT";
property="EM_VARIABLEATTRIBUTES";
value= "WORK.FIMPORT_VariableAttribute";
output;
id= "FIMPORT";
property="EM_FILE_USERTRAINCODE";
value= "FIMPORT_USERTRAINCODE.sas";
output;
id= "FIMPORT";
property="EM_FILE_VARIABLESETDELTA";
value= "FIMPORT_VARIABLESETDELTA.txt";
output;
id= "FIMPORT";
property="EM_FILE_DELTACODE";
value= "FIMPORT_DELTACODE.txt";
output;
id= "FIMPORT";
property="EM_FILE_EMNOTES";
value= "FIMPORT_EMNOTES.txt";
output;
id= "Clus";
property="Bins";
value= "100";
output;
id= "Clus";
property="Clusvar";
value= "_SEGMENT_";
output;
id= "Clus";
property="ClusvarLabel";
value= "Segment Variable";
output;
id= "Clus";
property="ClusvarRole";
value= "SEGMENT";
output;
id= "Clus";
property="MaxC";
value= "3";
output;
id= "Clus";
property="NominalEncoding";
value= "GLM";
output;
id= "Clus";
property="OrdinalEncoding";
value= "RANK";
output;
id= "Clus";
property="MissingInterval";
value= "DEFAULT";
output;
id= "Clus";
property="MissingNominal";
value= "DEFAULT";
output;
id= "Clus";
property="MissingOrdinal";
value= "DEFAULT";
output;
id= "Clus";
property="ImputationMethod";
value= "NONE";
output;
id= "Clus";
property="HideVariable";
value= "Y";
output;
id= "Clus";
property="TrainDefaults";
value= "Y";
output;
id= "Clus";
property="Learn";
value= ".";
output;
id= "Clus";
property="LearnInitial";
value= "0.5";
output;
id= "Clus";
property="LearnFinal";
value= "0.02";
output;
id= "Clus";
property="LearnSteps";
value= "1000";
output;
id= "Clus";
property="MaxIter";
value= "10";
output;
id= "Clus";
property="MaxSteps";
value= "1200";
output;
id= "Clus";
property="XConv";
value= "0.0001";
output;
id= "Clus";
property="Initial";
value= "DEFAULT";
output;
id= "Clus";
property="Drift";
value= "N";
output;
id= "Clus";
property="Radius";
value= "0";
output;
id= "Clus";
property="Stdize";
value= "STD";
output;
id= "Clus";
property="Summary";
value= "N";
output;
id= "Clus";
property="TreeProfile";
value= "Y";
output;
id= "Clus";
property="ClusterGraphs";
value= "Y";
output;
id= "Clus";
property="NumberClusterMethod";
value= "USER";
output;
id= "Clus";
property="DistancePlot";
value= "Y";
output;
id= "Clus";
property="FinalMaxNum";
value= "20";
output;
id= "Clus";
property="AutomaticMaxNum";
value= "50";
output;
id= "Clus";
property="AutomaticMinNum";
value= "2";
output;
id= "Clus";
property="AutomaticMethod";
value= "WARD";
output;
id= "Clus";
property="CCCCutOff";
value= "3";
output;
id= "Clus";
property="ForceRun";
value= "N";
output;
id= "Clus";
property="RunAction";
value= "Train";
output;
id= "Clus";
property="Component";
value= "Cluster";
output;
id= "Clus";
property="EM_FILE_EMNOTES";
value= "Clus_EMNOTES.txt";
output;
run;
*------------------------------------------------------------*;
* Create connections data set;
*------------------------------------------------------------*;
data connect;
length from to $12;
from="FIMPORT";
to="Clus";
output;
run;
*------------------------------------------------------------*;
* Create actions to run data set;
*------------------------------------------------------------*;
%macro emaction;
%let actionstring = %upcase(&EM_ACTION);
%if %index(&actionstring, RUN) or %index(&actionstring, REPORT) %then %do;
data actions;
length id $12 action $40;
id="Clus";
%if %index(&actionstring, RUN) %then %do;
action='run';
output;
%end;
%if %index(&actionstring, REPORT) %then %do;
action='report';
output;
%end;
run;
%end;
%mend;
%emaction;
*------------------------------------------------------------*;
* Execute the actions;
*------------------------------------------------------------*;
%em5batch(execute, workspace=workspace, nodes=nodes, connect=connect, datasources=datasources, nodeprops=nodeprops, action=actions);
