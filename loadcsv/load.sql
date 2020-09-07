set colsep ,
set feedback off
set heading off
set trimout on
set linesize 1000
set newp none
alter session set NLS_NUMERIC_CHARACTERS = '.,'

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\metriccost.csv
set trimspool on
select 'day','metric','actionname','timecost' from dual;
select day || ',' || metric || ',' || actionname || ',' || timecost from (select * from ACTION_COST order by day desc) where rownum <= 60;
spool off

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\metriccount.csv
set trimspool on
select 'day','actionname','times' from dual;
select day || ',' || actionname || ',' || times from ACTION_COUNT where day in (  
select day from (
select * from 
(select distinct day from ACTION_COUNT order by day desc) where rownum <= 60) t ) order by day desc;
spool off

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\usercount.csv
set trimspool on
select 'day','usercnt' from dual;
select day || ',' || usercnt from (
select * from (
select day,count(username) as usercnt from (
select distinct 
substr(sessionstartdate, 25, 4) || '-' || 
        case when substr(sessionstartdate, 5,3) = 'Jan' then '01' 
        when substr(sessionstartdate, 5,3) = 'Feb' then '02' 
        when substr(sessionstartdate, 5,3) = 'Mar' then '03' 
        when substr(sessionstartdate, 5,3) = 'Apr' then '04' 
        when substr(sessionstartdate, 5,3) = 'May' then '05' 
        when substr(sessionstartdate, 5,3) = 'Jun' then '06' 
        when substr(sessionstartdate, 5,3) = 'Jul' then '07' 
        when substr(sessionstartdate, 5,3) = 'Aug' then '08' 
        when substr(sessionstartdate, 5,3) = 'Sep' then '09' 
        when substr(sessionstartdate, 5,3) = 'Oct' then '10' 
        when substr(sessionstartdate, 5,3) = 'Nov' then '11'  else '12' end || '-' || 
        substr(sessionstartdate, 9, 2)
as day,username from HEARTBEAT) t group by day order by day desc) where rownum <= 60) t 
order by day  ;
spool off

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\reportcost.csv
set trimspool on
select 'day','actionname','metric','timecost' from dual;
select day || ',' || actionname || ',' || metric || ',' || replace(to_char(timecost), ',', '.') from REPORT_COST where day in (  
select day from (
select day from (
select distinct day from REPORT_COST order by day desc) where rownum <= 60)) order by day desc;
spool off

spool C:\Users\davinciadmin\stadiumLogAnalysis\loadcsv\reportcount.csv
set trimspool on
select 'day','actionname','type','times' from dual;
select day || ',' || actionname || ',' || type || ',' || times from REPORT_COUNT where day in (  
select day from (
select day from (
select distinct day from REPORT_COUNT order by day desc) where rownum <= 60) t ) order by day desc;
spool off

exit