ods listing file='c:\temp\Shoes.txt';

*** Africa ***;

title1 'Region: Africa';
proc summary data=sashelp.shoes nway;
	where region = 'Africa';
	class region product;
	var stores sales returns;
	output out=shoes_Africa(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_Africa;
	set shoes_Africa;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_Africa;
	by descending slrps;
run;
data shoes_Africa_top;
	set shoes_Africa(obs=3);
run;
proc sort data=shoes_Africa;
	by slrps;
run;
data shoes_Africa_bottom;
	set shoes_Africa(obs=3);
run;
proc sort data=shoes_Africa_bottom;
	by descending slrps;
run;

data Africa;
	set shoes_Africa_top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_Africa_bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=Africa label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_Africa:;
	run;
quit;


*** Asia ***;

title1 'Region: Asia';
proc summary data=sashelp.shoes nway;
	where region = 'Asia';
	class region product;
	var stores sales returns;
	output out=shoes_Asia(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_Asia;
	set shoes_Asia;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_Asia;
	by descending slrps;
run;
data shoes_Asia_top;
	set shoes_Asia(obs=3);
run;
proc sort data=shoes_Asia;
	by slrps;
run;
data shoes_Asia_bottom;
	set shoes_Asia(obs=3);
run;
proc sort data=shoes_Asia_bottom;
	by descending slrps;
run;

data Asia;
	set shoes_Asia_top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_Asia_bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=Asia label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_Asia:;
	run;
quit;


*** Canada ***;

title1 'Region: Canada';
proc summary data=sashelp.shoes nway;
	where region = 'Canada';
	class region product;
	var stores sales returns;
	output out=shoes_Canada(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_Canada;
	set shoes_Canada;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_Canada;
	by descending slrps;
run;
data shoes_Canada_top;
	set shoes_Canada(obs=3);
run;
proc sort data=shoes_Canada;
	by slrps;
run;
data shoes_Canada_bottom;
	set shoes_Canada(obs=3);
run;
proc sort data=shoes_Canada_bottom;
	by descending slrps;
run;

data Canada;
	set shoes_Canada_top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_Canada_bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=Canada label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_Canada:;
	run;
quit;

*** repeat for remaining 7 Regions (500 lines of code total) ***;
title;
ods listing;












ods listing file='c:\temp\Shoes.txt';

*** Central America/Caribbean ***;
%let Region=Central America/Caribbean;
data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;


title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._top;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by slrps;
run;
data shoes_&REGIONDSN._bottom;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN._bottom;
	by descending slrps;
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_&REGIONDSN._bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=&REGIONDSN label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;



*** Eastern Europe ***;
%let Region=Eastern Europe;
data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;


title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._top;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by slrps;
run;
data shoes_&REGIONDSN._bottom;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN._bottom;
	by descending slrps;
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_&REGIONDSN._bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=&REGIONDSN label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;




*** Middle East ***;
%let Region=Middle East;
data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;


title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._top;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by slrps;
run;
data shoes_&REGIONDSN._bottom;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN._bottom;
	by descending slrps;
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_&REGIONDSN._bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=&REGIONDSN label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;

*** repeat for remaining 7 Regions (550 lines of code total) ***;



/*  */;
ods listing;





%macro TopBottomShoes(Region);
data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;

title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps dollar12.;
	label slrps ='Sales (Less Returns) Per Store';
	slrps = (sales - returns) / stores;
run;

title2 'Top/Bottom 3 Products';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._top;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by slrps;
run;
data shoes_&REGIONDSN._bottom;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN._bottom;
	by descending slrps;
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._top(rename=(product=Top_Product slrps=Top_slrps));
	set	shoes_&REGIONDSN._bottom(rename=(product=Bottom_Product slrps=Bottom_slrps));
	keep top_: bottom_:;
run;
proc print data=&REGIONDSN label;
	var top_: bottom_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;
%mend;

/* explicit call for each region */;
ods listing file='c:\temp\Shoes.txt';
%TopBottomShoes(Africa);
%TopBottomShoes(Asia);
%TopBottomShoes(Canada);
%TopBottomShoes(Central America/Caribbean);
%TopBottomShoes(Eastern Europe);
%TopBottomShoes(Middle East);
%TopBottomShoes(Pacific);
%TopBottomShoes(South America);
%TopBottomShoes(United States);
%TopBottomShoes(Western Europe);
%TopBottomShoes(South America);
%TopBottomShoes(United States);
ods listing;



/* generate control file for all regions */;
proc freq data=sashelp.shoes;
	table Region / noprint out=Regions;
run;
data _null_;
	set regions;
	calltext = cats('%', 'TopBottomShoes(', Region, ');');
	file 'shoe regions.sas';
	put calltext;
run;

ods listing file='c:\temp\Shoes.txt';
%inc 'shoe regions.sas';
ods listing;






/*  */;






%macro TopSalesDebtShoes(Region);
data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;

title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns inventory;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns inventory)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps isrps dollar12.;
	label slrps='Sales (Less Returns) Per Store'
		isrps='Debt per Store';
	slrps = (sales - returns) / stores;
	isrps = (inventory - sales + returns) / stores;
run;

title2 'Top 3 Product Sales/Debt';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._sales;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by descending isrps;
run;
data shoes_&REGIONDSN._debt;
	set shoes_&REGIONDSN(obs=3);
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._sales(rename=(product=Top_Product_Sales slrps=Top_Sales));
	set	shoes_&REGIONDSN._debt(rename=(product=Top_Product_Debt isrps=Top_Debt));
	keep top_:;
run;
proc print data=&REGIONDSN label;
	var top_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;
%mend;
/* generate control file for all regions */;
proc freq data=sashelp.shoes;
	table Region / noprint out=Regions;
run;
data _null_;
	set regions;
	calltext = cats('%', 'TopSalesDebtShoes(', Region, ');');
	file 'Shoe Sales & Debt.sas';
	put calltext;
run;
ods listing file='Shoe Sales & Debt.txt';
%inc 'Shoe Sales & Debt.sas';
ods listing;


%TopSalesDebtShoes(South America);






%macro TopSalesDebtShoes(Region);
%local macro;
%let macro=&SYSMACRONAME;

%if %upcase("&REGION") eq "HELP" %then %do;
	%put;
	%put //// &SYSMACRONAME. information;
	%put Extracts top products for Sales and Debt for specified region from SASHELP.SHOES.;
	%put;
	%put //// Positional Parameters (in this order):;
	%put 1. Region: Course section start date begin in date9 format. If null, first of current month;
	%put;
	%put //// Optional Keyword Parameters (in any order):;
	%put -none-;
	%put;
	%put //// Notes:;
	%put -none-;
	%put;
	dm log 'show';
	%goto ByeBye;
%end;

*** use of this macro will be tracked ***;
%tracker(Macro, &MACRO);

data _null_;
	format dsn $19.;
	dsn = compress("&REGION", , 'ka');
	call symput('regiondsn', trim(dsn));
run;

title1 "Region: &REGION";
proc summary data=sashelp.shoes nway;
	where region = "&REGION";
	class region product;
	var stores sales returns inventory;
	output out=shoes_&REGIONDSN(drop=_:)
		n(stores)=
		sum(sales returns inventory)=;
run;
data shoes_&REGIONDSN;
	set shoes_&REGIONDSN;
	format slrps isrps dollar12.;
	label slrps='Sales (Less Returns) Per Store'
		isrps='Debt per Store';
	slrps = (sales - returns) / stores;
	isrps = (inventory - sales + returns) / stores;
run;

title2 'Top 3 Product Sales/Debt';
proc sort data=shoes_&REGIONDSN;
	by descending slrps;
run;
data shoes_&REGIONDSN._sales;
	set shoes_&REGIONDSN(obs=3);
run;
proc sort data=shoes_&REGIONDSN;
	by descending isrps;
run;
data shoes_&REGIONDSN._debt;
	set shoes_&REGIONDSN(obs=3);
run;

data &REGIONDSN;
	set shoes_&REGIONDSN._sales(rename=(product=Top_Prod_Sales slrps=Top_Sales));
	set	shoes_&REGIONDSN._debt(rename=(product=Top_Prod_Debt isrps=Top_Debt));
	keep top_:;
run;
proc print data=&REGIONDSN label;
	var top_:;
run;

proc datasets library=work nodetails nolist;
	delete shoes_&REGIONDSN:;
	run;
quit;
%ByeBye:;
%mend;

%TopSalesDebtShoes(HELP);

/* generate control file for all regions */;
proc freq data=sashelp.shoes;
	table Region / noprint out=Regions;
run;
data _null_;
	set regions;
	calltext = cats('%', 'TopSalesDebtShoes(', Region, ');');
	file 'Shoe Sales & Debt.sas';
	put calltext;
run;
ods listing file='Shoe Sales & Debt.txt';
%inc 'Shoe Sales & Debt.sas';
ods listing;
title;

%TopSalesDebtShoes(HELP);

proc means data=sys.tracker n;
	format description sysUserID $20.;
	where action eq 'MACRO'
	and description like 'TOP%SHOES'
	and datepart(datetime) ge "&SYSDATE9."d-7;
	class sysUserID Description;
	var datetime;
	types sysUserID Description;
run;
