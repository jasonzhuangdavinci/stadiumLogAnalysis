set colsep ,
set feedback off
set heading off
set trimout on
set linesize 1000
set newp none
alter session set NLS_NUMERIC_CHARACTERS = '.,'

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\outletmetriccost.csv
set trimspool on
select 'day','metric','actionname','timecost' from dual;
select day || ',' || metric || ',' || actionname || ',' || timecost from (select * from ACTION_COST order by day desc) where rownum <= 60;
spool off

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\outletmetriccount.csv
set trimspool on
select 'day','actionname','times' from dual;
select day || ',' || actionname || ',' || times from ACTION_COUNT where day in (  
select day from (
select * from 
(select distinct day from ACTION_COUNT order by day desc) where rownum <= 60) t ) order by day desc;
spool off

exit