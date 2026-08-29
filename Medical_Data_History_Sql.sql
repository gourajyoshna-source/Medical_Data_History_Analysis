# 1. To show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name, gender FROM patients WHERE gender = 'M';

# 2. To show first name and last name of patients who does not have allergies
SELECT first_name, last_name FROM patients WHERE allergies IS NULL;

# 3. To show first name of patients that start with letter 'C'
SELECT first_name FROM patients WHERE first_name LIKE 'C%';

# 4. To show first name and last name of patients that weight within the range of 100-120 (inclusive)
SELECT first_name, last_name FROM patients WHERE weight BETWEEN 100 AND 120;

# 5. To update the patients table for the allergies column. If the patient's allergy 
#     is null  then replace it with 'NKA'
SELECT patient_id, first_name, last_name,
COALESCE(allergies, 'NKA') AS allergies
FROM patients;

# 6. To show first name and last name concatenated into one column to show their full name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM patients;

#7. To show first name, last name and full province name of each patients
SELECT p.first_name, p.last_name, pn.province_name FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

# 8. To show how many patients have a birth_date with 2010 as the birth year
SELECT COUNT(*) AS patient_count FROM patients WHERE YEAR(birth_date) = 2010;

# 9. To show the first_name, last_name, and height of the patient with greatest height
SELECT first_name, last_name, height FROM patients 
WHERE height = (SELECT MAX(height) FROM patients);

# 10. To show all the columns for patients who have one of the following patient_ids: 1,25,534,879,1000
SELECT * FROM patients WHERE patient_id IN (1, 45, 534, 879, 1000);

# 11. To show the total number of admissions
SELECT COUNT(*) AS total_admisiions FROM admissions;

# 12. To show all the columns from admissions where the patient was admitted and discharged on the same day
SELECT * FROM admissions WHERE DATE(admission_date) = DATE(discharge_date);

# 13. To show the total number of admissions for patient_id 579
SELECT COUNT(*) AS total_admissions FROM admissions WHERE patient_id = 579;

# 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'
SELECT DISTINCT city FROM patients WHERE province_id = 'NS';

# 15. To find the first_name, last_name and birth_date of patients ho have height more than 160 and weigght more than 70
SELECT first_name, last_name, birth_date FROM patients WHERE height > 160 AND weight > 70;

# 16. To show unique birth years from patients and order them by ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year FROM patients ORDER BY birth_year ASC;

# 17. TO show unique first names from patients table which only occurs once in the list
SELECT first_name FROM patients GROUP BY first_name HAVING COUNT(*) = 1;

# 18. To show patient_id and first_name from patients where their first_name starts and ends with 's' and is atleast 6 characters long
SELECT patient_id, first_name FROM patients WHERE first_name LIKE 's%s' AND LENGTH(first_name) >= 6;

# 19. To show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'
SELECT DISTINCT p.patient_id, p.first_name, p.last_name FROM patients p 
JOIN admissions a ON p.patient_id = a.patient_id WHERE a.diagnosis = 'Dementia';

# 20. To display every patient's first_name. Order the list by length of each name and then alphabetically
SELECT first_name FROM patients ORDER BY LENGTH(first_name), first_name;

# 21. To show the total amount of male patients and the total amount of female patients in the patients table.
# Display the two results in the same row.
SELECT 
	SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS
male_count,
	SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS
female_count
FROM patients;

# 22. To show the total amount of male patients and the total amount of female patients in the patients table.
# Display the two results in the same row.
SELECT 
	SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS
male_count,
	SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS
female_count
FROM patients;

# 23.To show patient_id and diagnosis from admissions. Find patients admitted multiple times for the same diagnosis
SELECT patient_id, diagnosis, COUNT(*) AS admission_count FROM admissions
GROUP BY patient_id, diagnosis HAVING COUNT(*) > 1 ORDER BY patient_id, diagnosis;

# 24. To show the city and the total number of patients in the city. Order from most to least patients and the by city name ascending
SELECT city, COUNT(*) AS patient_count FROM patients
GROUP BY city ORDER BY patient_count DESC, city ASC;

# 25. To show first name, last name and role of every person that is either patient or doctor
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;

# 26. TO show all allergies ordered by popularity. Remove n=NULL values from query
SELECT allergies, COUNT(*) AS allergy_count FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies ORDER BY allergy_count;

# 27. To show all patient's first_name, last_name, and birth_date who were born in he 1970s decade.
# Sort the list starting from the earliest birth_date
SELECT first_name, last_name, birth_date FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979 ORDER BY birth_Date ASC;

# 28. Display each patients's full name with last name in upper case and first name in lower case, separated by comma, ordered by first name ascending
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name FROM patients
ORDER BY first_name ASC;

# 29. To show the province_id(s), sum of height where the total sum of it's patient height is greater than or equal to 7000
SELECT province_id, SUM(height) AS total_height FROM patients
GROUP BY province_id HAVING SUM(height) >= 7000;

# 30. To show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_difference FROM patients WHERE last_name = 'Maroni';

# 31. To show all of the days of the month (1-31) and how many admission_dates occurred on that day
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admission_count FROM admissions
GROUP BY DAY(admission_Date) ORDER BY admission_count DESC;

# 32. To show all of the patients grouped into weight group ordered by weight group descending
SELECT 
	FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY FLOOR(weight / 10) * 10 
ORDER BY weight_group DESC;

# 33. TO show patient_id, weight, height, isObese from the patients table
SELECT patient_id, weight, height,
	CASE WHEN weight / ((height / 100) * (height / 100)) >= 30 THEN 1 ELSE 0 END AS isObese 
    FROM patients;
    
# 34. TO show patient_id, first_name, last_name, and attending doctor's specialty for Epilepsy patients with doctor Lisa
SELECT p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';