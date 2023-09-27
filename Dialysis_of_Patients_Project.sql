create database healthcare;
use healthcare;
select * from dialysis_1;
select * from dialysis_2;

-- KPI 1:Number of patients across various summary
select
sum(`Number of patients included in the transfusion summary`) as 'Transfusion Patients',
sum(`Number of patients in hypercalcemia summary`) as 'Hypercalcemia Patients',
sum(`Number of patients in Serum phosphorus summary`) as 'Serum phosphorus Patients',
sum(`No of patients included in hospitalization summary`) as 'Hospitalization Patients',
sum(`No of Patients included in survival summary`) as 'Survival Patients',
sum(`Number of Patients included in fistula summary`) as 'Fistula Patients',
sum(`Number of patient months in long term catheter summary`) as 'Long term catheter Patients',
sum(`Number of patients in nPCR summary`) as 'nPCR Patients',
sum(`Number of patients in this facility for SWR`) as 'facility for SWR Patients'
from dialysis_1;


-- KPI 2:Profit vs Non Profit stats
select `Profit or Non-Profit`,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()AS percentage 
FROM 
    dialysis_1
GROUP BY 
    `Profit or Non-Profit`;

-- KPI 3:Chain organization w.r.t. Total Performance Score as no score
select d1.`Chain Organization`,count(d2.`Total Performance Score`) as "No_score_count"
from dialysis_1 as d1 
left join dialysis_2  as d2 
on d1.`Facility Name` = d2.`Facility Name` and d2.`Total Performance Score` = "No score"
group by d1.`Chain Organization`
order by No_score_count desc;

-- KPI 4: Dialysis stations stats
select `State`, 
count(`# of Dialysis Stations`) as 
"Number of dialysis stations"
from dialysis_1
group by `State`
order by `Number of dialysis stations`;

select `City`, 
count(`# of Dialysis Stations`) as
"Number of dialysis stations"
from dialysis_1
group by `City`
order by `Number of dialysis stations` desc;

-- KPI 5: Average Payment Reduction rate
select round(avg(substring_index(`PY2020 Payment Reduction Percentage`,'%',1)),2) 
as "Avg. Payment Reduction Rate"
from dialysis_2;