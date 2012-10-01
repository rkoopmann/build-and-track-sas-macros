/*********************************************************************************\
PROGRAM INFORMATION
Project : autocall utilities
Purpose : track an action back to user and datetime
Inputs  : -none-
Outputs : sasuser.tracker
Notes   : contents of sasuser.tracker are appended to shared data set before being purged

PROGRAM HISTORY
2009-03-27 RK Initial program developed.
2012-10-01 RK Handles missing data set, adds upload action.
\*********************************************************************************/;


%macro tracker(
  action
, description
);

%local macro;
%let macro=&SYSMACRONAME;

%if %upcase(&ACTION) eq HELP %then %do;
  %put ***********************************************************************************;
  %put * TRACKER  Tracks actions and events for usage-tracking.                          *;
  %put ***********************************************************************************;
  %put * Positional Parameters (in this order):                                          *;
  %put *  ACTION    Brief description of what kind of action was taken by user.          *;
  %put *  DESCRIPTION  Description of this action, if needed.                            *;
  %put *                                                                                 *;
  %put * Optional Keyword Parameters (in any order):                                     *;
  %put *  -none-                                                                         *;
  %put ***********************************************************************************;
  %put * Example macro call                                                              *;
  %put *   tracker(Connection, Logged in to SAS Main)                                    *;
  %put ***********************************************************************************;
  dm log 'show';
  %goto ByeBye;
%end;

%else %if %upcase(&ACTION) eq UPLOAD %then %do;
  option nonotes;
  libname _t 'shared-network-drive';
  proc append base=_t.tracker data=sasuser.tracker;
  run;
  data sasuser.tracker;
    set _t.tracker;
    stop;
  run;
  libname _t clear;
  option notes;
  %goto ByeBye;
%end;

option nonotes;
*** if the local copy of the tracker data set does not exist, spawn a copy ***;
%if %sysfunc(exist(sasuser.tracker)) = 0 %then %do;
  libname _t 'shared-network-drive';
  data sasuser.tracker;
    set _t.tracker;
    stop;
  run;
  libname _t clear;
%end;

proc sql;
insert into sasuser.tracker
  set sysuserid=upcase("&SYSUSERID")
, Action=upcase("&ACTION")
, Description=upcase("&DESCRIPTION")
, datetime=dhms(today(),0,0,time())
;
quit;
option notes;

%ByeBye:;


%mend;

