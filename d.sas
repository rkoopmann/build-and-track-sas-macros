/*********************************************************************************\
PROGRAM INFORMATION
Project : Autocall utilities
Purpose : Returns DATE in the specified format.
Inputs  : -none-
Outputs : -none-
Notes   : can be used in most places in code where a date value is needed. also log window.

PROGRAM HISTORY
2008-04-14 RK Initial program developed.
2009-11-06 RK To LEFT align output, need to QUOTE first then UNQUOTE.
\*********************************************************************************/;


%macro d(
  format
, d=&SYSDATE9
, interval=day
, increment=0
, alignment=b
);
%local macro; %let macro=&SYSMACRONAME;

%if &FORMAT eq %then %let format = date9;

%else %if %upcase(&FORMAT) eq HELP %then %do;
  %put ***********************************************************************************;
  %put * D Returns a date value in the specified format.                                 *;
  %put ***********************************************************************************;
  %put * Positional Parameters (in this order):                                          *;
  %put *  FORMAT    The format to return DATE in. Defaults to date9.                     *;
  %put *                                                                                 *;
  %put * Optional Keyword Parameters (in any order):                                     *;
  %put *  D         Date value to use entered in date9 format. Defaults to SYSDATE9.     *;
  %put *  INTERVAL  Interval to shift the DATE parameter by. Defaults to day.            *;
  %put *  INCREMENT Amount to shift the DATE parameter by. Defaults to 0.                *;
  %put *  ALIGNMENT Sets the position of the result. Defaults to b(eginning).            *;
  %put ***********************************************************************************;
  %put * Example macro call (replace # with standard percent symbol)                     *;
  %put *  #d(worddate, d=07DEC1942, interval=month, increment=5, alignment=s)            *;
  %put *  #d(increment=3, d=#d(d=19NOV1863, interval=year.7, increment=-87))             *;
  %put ***********************************************************************************;
  dm log 'show';
  %goto ByeBye;
%end;

%else %if %upcase(&FORMAT) eq EDIT %then %do;
  %EditMacro(&MACRO);
  %goto ByeBye;
%end;

%unquote(%left(%quote(%sysfunc(intnx(&INTERVAL, "&D"d, &INCREMENT, &ALIGNMENT), &FORMAT..))))

%ByeBye:
%mend  d;
