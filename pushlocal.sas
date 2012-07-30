/*********************************************************************************\
PROGRAM INFORMATION
Project : General Utility
Purpose : Push local variables to the server
Inputs  : -none-
Outputs : macro variables on the server
Notes   : Simply make a copy of the current value for all macro variables local to a macro on the server.

PROGRAM HISTORY
31Aug2010 RK Initial program developed.
\*********************************************************************************/;

%macro pushlocal(
	MACRO,
	debug=FALSE
);

proc sql;
	create table _local_(label=Local variables used by &MACRO. macro) as
	select distinct name, value
	from dictionary.macros
	where scope eq "&MACRO";
quit;

data _null_;
	set _local_ end=last;
	calltext=catx(' ', '%syslput', catx('=', name, value), ';');
	call execute(calltext);
	put name @20 value;
run;

%if %upcase("&DEBUG") ne "TRUE" %then %do;
	proc datasets library=work nodetails nolist;
		delete _local_; run;
	quit;
%end;

%mend;
