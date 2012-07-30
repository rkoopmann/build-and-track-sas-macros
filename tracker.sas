/*********************************************************************************\
PROGRAM INFORMATION
Project : autocall utilities
Purpose : track an action back to user and datetime
Inputs  : -none-
Outputs : sasuser.tracker
Notes   : contents of sasuser.tracker are appended to shared data set before being purged

PROGRAM HISTORY
2009-03-27 RK Initial program developed.
\*********************************************************************************/;


%macro tracker(
  action
, description
);
%local macro; %let macro=&SYSMACRONAME;

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

%else %if %upcase(&ACTION) eq EDIT %then %do;
  %EditMacro(&MACRO);
  %goto ByeBye;
%end;

option nonotes;
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
