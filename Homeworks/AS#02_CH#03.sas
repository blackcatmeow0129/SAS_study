/* 3장 실습문제 */

/* 3.1 */
data stat2.exam3_1;
	set stat2.exam2_3;
	tot = mid + final;
	avr = round(tot / 2, 1);
run;
proc print data=stat2.exam3_1;
run;


/* 3.2 */
data stat2.exam3_2;
	set stat2.exam3_1 (keep = id avr);
	if avr >= 90 then grade = 'A';
	else if avr >= 80 then grade = 'B';
	else if avr >= 70 then grade = 'C';
	else if avr >= 60 then grade = 'D';
	else grade = 'F';
run;
proc print data=stat2.exam3_2;
run;







