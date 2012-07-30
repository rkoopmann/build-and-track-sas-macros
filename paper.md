# Building Macros and Tracking Their Use

Many of the routine tasks we do in SAS can be converted into parameterized macros[^repetition]. Whether you are pulling standard data sets for regular reports, preforming a number of statistical tests for an ad hoc request, or some other low-level function (such as generating sets of `%SYSLPUT` statements for executing macros in a client-server environment), macros can help make repetitious tasks more tolerable. Developing a common macro script structure and committing to it are just the first steps toward having a more concise code base.

One immediate benefit of using macros is the ease of implementing code changes. Typically, estimating the impact of impending source changes (e.g., adding a column, renaming a schema, or deleting a table in a SQL database) is a distributed task---end-users are asked to identify potential breaks in their code base. If the end-users tend to work with different versions of their code for different projects or requests, the number of SAS files to scour through quickly multiplies. With macros, however, there will be a small fraction of SAS files to evaluate. Further, when it comes time to implement the changes, working with a smaller number of macros will always be easier than working with a larger number of files.

Macros, however, have a tendency to proliferate in their own right, though this is hopefuly the result of identifying new opportunities for macros to replace longer pieces of code (or at least make it more succinct). With many macros being used throughout an organization, being able to track their use becomes equally important. 

Simply asking SAS users which macros they use is an option, but this too will likely be inconsistent and incomplete. Adding a few lines of code to individual macros can make tracking a trivial task.

Tracking _what_ macros are called _when_ and by _whom_ provides those responsible for maintaining the macros with vital informaiton which can be leveraged to gather targeted feedback regarding upgrades or help identify macros to be discontinued.

This paper outlines framework for developing component macros that report back macro usage. While the framework was developed in a SAS 9.1/9.2 client-server environment (running under Windows XP, 32-bit), it should work under any client-server environment and could be modified to run under disparate clients sharing a common networked drive.

--------

# Building Macros

## Turning Code Into Macro Code

Removing static values from a piece of code is the first step toward making that code generalizable and reusable in similar contexts. On its surface, the process of converting a piece of working code into afunctioning, parameterized macro is straightforward:

1. Identify the parameters in the working code.
2. Convert these parameters to macro variables.
3. Wrap code in a macro definition and add corresponding named or positional parameters.

Simply stopping at that point, the macro should perform as expected and the end-users will experience the benefit of concise code. However, adding some inline help documentation to the macro will help new users of the macros become acquainted with the different parameters and the options.

## A Macro Template

The following macro code outline is the result of many years of of refinements to macros developed for use by a small number of analysts:

1. Documentation header
	1. Project -- what project was the code developed for?
	2. The purpose of the code -- what is it supposed to do?
	3. Inputs -- any input data sets? external files?
	4. Outputs -- what are the resulting data sets? lowg output? external files?
	5. Notes -- anything that you'd like to share with others?
	6. Changelog -- major changes are summarized, dated, and attributed to an individual
2. Macro definition statement
3. Setting sensible defaults
4. Inline help
5. Use Tracker
6. The "meat" of the macro code is here
7. Cleanning up

## Documentation Header

Whether it's a valid criterion or not, I tend to judge the value of a script based on the amount of comments and documentation that comes along with it. 

## Sensible Defaults

## Inline Help

# Tracking Use

Some concerns with releasing a macro into the wild is that you generally don't know where it goes (who is using it), how popular it becomes (how frequently it gets called), or when it is time to retire it (when people stop using it). Additionally, the author of the macro often becomes its single source of support---though this burden can be lessened by providing in-line documentation, by naming parameters consistent with source variables, by using sensible default parameter values, and by sharing the macro source code for the curious.

These concerns are most easily resolved by tracking each time a macro is called. Since SAS compiles a macro from source only once (subsequent calls in the same session rely on the compiled version), the tracking cannot occur at the system level. One integrated tracking approach is accomplished by inserting a timestamped record into a permanent data set. For example,

    proc sql noprint;
    insert into sasuser.tracker
      set sysuserid=upcase("&SYSUSERID")
    , Action=upcase("A brief description")
    , Description=upcase("A detailed description of what is being tracked")
    , datetime=dhms(today(),0,0,time());
    quit;

The idea of tracking macro use _without_ using a macro seemed silly, so this static code was converted into a macro called `%TRACKER` accepting 2 parameters:

1. Action -- a brief description of what type of action is being logged (e.g., _Login_, _Macro_).
2. Description -- a more detailed description of the action (e.g., _Connect to server_, Name of macro being called)

Once the to-be-tracked macro has been built, adding the code to trigger the `%TRACKER` macro is a simple matter of adding three statments. To prepare, add these two statments near the top of the to-be-tracked macro (shortly after the `%macro xxx(...);` statement):

    %local macro;
    %let macro=&SYSMACRONAME;

After any inline help that may be in the to-be-tracked macro[^ontrackinghelp], add the following statement to trigger the `%TRACKER` macro:

    %tracker(Macro, &MACRO);

## Client-Server Evnironments

At this point, in a single client environment, the tracking can stop. However, in a client-server environment, each client will need to push their accumulated tracker data up to a shared data set and then clear their local data set. Adding the following code to the `autoexec` will keep the centralized tracking data set up-to-date.

    libname sys 'path-to-common-directory';
    *** push local data ***;
    proc append base=sys.tracker data=sasuser.tracker;
    run;
    *** clear local data ***;
    data sasuser.tracker;
        set sys.tracker;
        stop;
    run;
    libname sys clear;
    dm log 'clear;';

Others may want to add some additional code to confirm the local data set has been appended prior to clearing. The last line tells the display manager to clear the log and may be excluded according to user preference.

## Simple Queries

Get the number of macro transactions logged inthe prior 6 weeks is a trivial task -- the `%d` macro returns a relative date value and is described below.

    proc freq data=sys.tracker order=freq;
        where action eq 'MACRO'
        and datepart(datetime)
        between "%d(interval=week, increment=-6)"d
            and "%d(interval=week)"d ;
        table Description / nocum;
    run;

And the (truncated) results:

    Description                                           Frequency     Percent
    ---------------------------------------------------------------------------
    EDWREGLITE                                                 141       28.89
    EXPEXCEL                                                    92       18.85
    RLIBNAME                                                    65       13.32
    EDWGRADLITE                                                 38        7.79
    EDWREGLITE_SAS                                              38        7.79


# Relevant Example Macros

# `%tracker`

As described above, the `%TRACKER` macro 

    %macro tracker(action, description);
    option nonotes;
    proc sql;
    insert into sasuser.tracker
      set sysuserid=upcase("&SYSUSERID")
    , Action=upcase("&ACTION")
    , Description=upcase("&DESCRIPTION")
    , datetime=dhms(today(),0,0,time());
    quit;
    option notes;
    %ByeBye:;
    %mend;

To avoid cluttering the log with notes irrelevant to the macro, the `nonotes`/`notes` option is toggled when inserting the record into the tracker data set.

# `%pushlocal`

Within macros, there are local and global variables--Local variables exist only within the scope of the containing macro. In client-server environments where macros are called and executed locally with portions of the code being `rsubmit`ted, it is vital to push local (client) macro variables up to the server. This tends to involve a series of `%SYSLPUT` statements. To facilitate this, the `%PUSHLOCAL` macro grabs the values of macro variables local to the calling macro and generates a series of `%SYSLPUT` statements which are subsequently `CALL EXECUTE`d.

    %macro pushlocal(MACRO, debug=FALSE);
    proc sql;
        create table _local_(label=Local variables used by &MACRO. macro) as
        select distinct name, value
        from dictionary.macros
        where scope eq "&MACRO";
    quit;
    data _null_;
        set _local_ end=last;
        calltext=catx(' ','%syslput',catx('=',name,value),';');
        call execute(calltext);
        put name @20 value;
    run;
    %if %upcase("&DEBUG") ne "TRUE" %then %do;
    proc datasets library=work nodetails nolist;
        delete _local_;
    run;
    quit;
    %end;
    %mend;


# `%d`

This is a simple utility macro which returns a formatted datevalue based on user specifications (defaults to `date9.`) format relative to a specified date (dafaults to value of `&SYSDATE9.`).

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

    %unquote(%left(%quote(%sysfunc(intnx(&INTERVAL, "&D"d, &INCREMENT, &ALIGNMENT), &FORMAT..))))

    %ByeBye:
    %mend  d;

# Conclusion


## Full Source Code

The most current version of code contained within this paper will be maintained on the [project page](https://github.com/rkoopmann/build-and-track-sas-macros) on GitHub. Additional relevant materials (e.g., this paper) will also maintained there.

## Contact Information

Your comments and questions are valued and encouraged. Contact the author at:

Name: [Richard Koopmann, Jr.](http://koopmann.us)  
Company: [Capella University](http://www.capella.edu)  
E-mail: <richard.koopmann@capella.edu>  
Web: <https://github.com/rkoopmann/build-and-track-sas-macros>


SAS and all other SAS Institute Inc. product or service names are registered trademarks or trademarks of SAS Institute Inc. in the USA and other countries. &copy; indicates USA registration.

Other brand and product names are trademarks of their respective companies. 


[^repetition]: In general, the more frequent a routine task needs to be performed with only minor variations, the more benefitial converting the code to a parameterized macro will be to the user.

[^ontrackinghelp]: The tracking macro should probably not be triggered if the user is triggering the inline help and only triggered after the user has submitted an apparently valid-looking macro.