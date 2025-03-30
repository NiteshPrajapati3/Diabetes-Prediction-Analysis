create database diabetes_predition;

use diabetes_predition;

select * from diabetes_prediction;

-- 1. Retrieve the Patient_id and ages of all patients.
select Patient_id, Age
from diabetes_prediction;


-- 2. Select all female patients who are older than 40.
select Patient_id, Age
from diabetes_prediction
where gender = "Female" > 40 ;


-- 3. Calculate the average BMI of patients.
select Patient_id, avg(bmi) as Avg_BMI
from diabetes_prediction
group by Patient_id;


-- 4. List patients in descending order of blood glucose levels.
select *
from diabetes_prediction
order by blood_glucose_level desc; 


-- 5. Find patients who have hypertension and diabetes.
select patient_id, EmployeeName, hypertension, diabetes
from diabetes_prediction
where hypertension = "1" and diabetes = "1";


-- 6. Determine the number of patients with heart disease.
select count(*) as heart_disease_patients
from diabetes_prediction
where heart_disease =1;


-- 7. Group patients by smoking history and count how many smokers and nonsmokers there are. 
SELECT smoking_history, COUNT(*) AS patients
FROM diabetes_prediction
GROUP BY smoking_history
ORDER BY patients DESC;

-- 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
SELECT Patient_id
FROM diabetes_prediction
WHERE bmi > (SELECT AVG(bmi) FROM diabetes_prediction);


-- 9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
SELECT EmployeeName, Patient_id, HbA1c_level
FROM diabetes_prediction
WHERE HbA1c_level = (SELECT MAX(HbA1c_level) FROM diabetes_prediction)
	or HbA1c_level = ( SELECT MIN(HbA1c_level) FROM diabetes_prediction);


-- 10. Calculate the age of patients in years (assuming the current date as of now).
SELECT Patient_id
	timestampdiff(year, 'D.O.B', current_date()) as Age
FROM diabetes_prediction;


-- 11. Rank patients by blood glucose level within each gender group.
SELECT Patient_id, gender, blood_glucose_level,
	RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level DESC) AS glucose_rank
FROM diabetes_prediction;

-- 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
update diabetes_prediction
set smoking_history = 'Ex-smoker'
where Age > '50';


-- 13. Insert a new patient into the database with sample data.
insert into diabetes_prediction
values ('Nitesh', '9009', 'male', '2000-10-15', 23, 0, 1, 'Non-smoker', 25.5, 6.2, 120,0);

SELECT *
FROM diabetes_prediction
WHERE EmployeeName = 'Nitesh';

-- 14. Delete all patients with heart disease from the database.
delete from diabetes_prediction
where heart_disease = 1;


-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator. 2 of 2
select EmployeeName, Patient_id, hypertension, diabetes
from diabetes_prediction
where hypertension = 1
and Patient_id not in (select Patient_id from diabetes_prediction where diabetes = 1);


-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
alter table diabetes_prediction
add constraint unique_patient_id unique (Patient_id);


-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.
create view patient_info_view as 
select Patient,
	timestampdiff(year, 'D.O.B',current_date()) as Age,
    bmi
from diabetes_prediction;

