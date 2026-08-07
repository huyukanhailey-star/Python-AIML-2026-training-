-- question1
# 1. Get all customers whose first name starts with 'J' and who are active.
SELECT * FROM customer;
SELECT * FROM customer WHERE last_name LIKE 'J%' and active = 1; 

# 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
SELECT * FROM film;
SELECT * FROM film WHERE title LIKE '%ACTION%' OR description LIKE '%WAR';

# 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
SELECT * FROM customer WHERE last_name != 'SMITH' and first_name LIKE '%a'; 

# 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
SELECT * FROM film WHERE replacement_cost is null;
SELECT * FROM film WHERE replacement_cost is not null AND rental_rate >3;

# 5. Count how many customers exist in each store who have active status = 1.
SELECT store_id, COUNT(*) AS count_activecustomers 
	FROM customer 
	WHERE active=1
	GROUP BY store_id;

# 6. Show distinct film ratings available in the film table.
SELECT count(distinct(rating)) FROM film;
SELECT distinct rating FROM film;

# 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
SELECT * FROM film WHERE rental_duration IS NULL;
SELECT * FROM film WHERE length IS NULL;
SELECT rental_duration,AVG(length) AS avg_legth
FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;

# 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
SELECT * FROM payment;
SELECT payment_date,date(payment_date) AS payment_day FROM payment;
SELECT date(payment_date), SUM(amount) as total_amount 
FROM payment
GROUP BY date(payment_date)
HAVING COUNT(amount) >100;

# 9. Find customers whose email address is null or ends with '.org'.
SELECT * FROM customer WHERE email REGEXP '[.org]$' OR email is null; 
SELECT * FROM customer WHERE email is null; 

# 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
SELECT * FROM film WHERE rating = 'G' or rating = 'PG'
ORDER BY rental_rate DESC;

# 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
SELECT title,length FROM film WHERE title LIKE 'T%';
SELECT length,COUNT(title) AS Tfilm
	FROM film
	WHERE title LIKE 'T%'
	GROUP BY length
	HAVING count(title)>5;

-- question2
# 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT CONCAT(first_name,last_name) AS full_name FROM customer;
SELECT DISTINCT CONCAT(first_name,last_name) AS full_name FROM customer;

# 2. Number of times letter 'a' is repeated in film descriptions
SELECT * FROM film;
SELECT description, LOWER(description) AS lowerdescription
FROM film
WHERE LOWER(description) LIKE '%a%'; # stuck here

# 3. Number of times each vowel is repeated in film descriptions 
SELECT description, LOWER(description) AS lowerdescription
FROM film
WHERE description REGEXP'[AEIOUaeiou]'; # stuck here

# 4. Display the payments made by each customer 1. Month wise 2. Year wise 3. Week wise
SELECT * FROM payment;
SELECT customer_id, amount, payment_date,
YEAR(payment_date) AS year,MONTH(payment_date) AS month, WEEKOFYEAR(payment_date) AS week
FROM payment;

# 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
SELECT CURDATE(),
    CASE 
    WHEN DAYOFYEAR('2026-12-31') = 365 THEN 'not leap year'
	WHEN DAYOFYEAR('2026-12-31') = 366 THEN 'leap year'
    END AS year_type;

# 6. Display number of days remaining in the current year from today.
SELECT CURDATE();
SELECT DATEDIFF('2026-12-30',CURDATE());

# 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT payment_id,customer_id,staff_id,rental_id,amount,payment_date,QUARTER(payment_date) AS quater,last_update
FROM payment
