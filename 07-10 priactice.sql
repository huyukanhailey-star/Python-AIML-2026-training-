-- Query Language pratice 07-10

# Select
SELECT * FROM actor;
SELECT DISTINCT last_name FROM actor;
SELECT * FROM country;
SELECT * FROM country WHERE country is null;
SELECT * FROM film;
SELECT * FROM language;

# check duplication in 'title'
SELECT DISTINCT title FROM film WHERE original_language_id is null;  # 1000
SELECT title FROM film WHERE original_language_id is null;  # same 1000
SELECT COUNT(*) FROM film;
SELECT COUNT(DISTINCT title) FROM film;
# count and distinct count, check same first names in actors
SELECT count(first_name) FROM actor; #200 rows retured
SELECT count(distinct(first_name)) FROM actor; #128 rows retured
SELECT first_name FROM actor
GROUP BY first_name
HAVING COUNT(first_name)>1; #52 rows retured : we have 52 duplicated first names in actors
SELECT * FROM actor WHERE first_name = 'MINNIE'; # 2 MINNIE, but with different last names

#limit
SELECT actor_id, first_name, last_name FROM actor limit 50;
# filter WHERE
SELECT * FROM film;
SELECT DISTINCT rating FROM film;
SELECT * FROM film WHERE rating = "PG" and length >=90;
SELECT * FROM film WHERE rating != "PG" and length >=90;
SELECT length FROM film ORDER BY length desc;
SELECT * FROM film WHERE rating = 'R'and length <90 ORDER BY rental_rate desc; 
SELECT * FROM film WHERE rating != 'R'and length <90 ORDER BY rental_rate desc; 

# two wild cards 'like' % _
SELECT title FROM film WHERE original_language_id like 'M%'; # want to check Mandarin language
SELECT original_language_id FROM film;
SELECT * FROM language;
SELECT * FROM film; # original language are all null, use language id here
SELECT * FROM language WHERE name like 'M%'; # try again to check Mandarin
SELECT * FROM country;
SELECT country FROM country WHERE country like 'N%';  # 6 rows returned
SELECT * FROM city;
SELECT city FROM city WHERE city like 'N%';  # 22 rows returned
SELECT country FROM country WHERE country like '_e%';  # 12 rows returned

# null 
SELECT * FROM rental; #1000 rows returned
SELECT rental_id, customer_id, rental_date, return_date FROM rental WHERE return_date is null; #183 rows returned
SELECT rental_id, customer_id, rental_date, return_date FROM rental WHERE return_date BETWEEN 2005-05-01 and 2006-02-15; # nothing

#group by and having
# check who rents more than 10
SELECT customer_id, COUNT(rental_id) as count_rental FROM rental 
GROUP BY customer_id HAVING COUNT(rental_id) >=10
ORDER BY count_rental desc limit 100; # customer_id 148 has 46 
SELECT * FROM customer WHERE customer_id = 148; # check customer info about customer_id 148
SELECT * FROM rental WHERE customer_id = 148; # check rental info about customer_id 148
# check who rents <30 but hasn't returned things
SELECT customer_id, COUNT(rental_id) as count_rental FROM rental 
WHERE return_date IS NULL
GROUP BY customer_id HAVING COUNT(rental_id) <30
ORDER BY count_rental desc limit 100;  # customer_id 75 has 3 unreturned 
SELECT * FROM customer WHERE customer_id = 75; # check customer info about customer_id 78
SELECT * FROM rental WHERE customer_id = 75; # inventory id 2476 4202 3688 unreturned
SELECT * FROM inventory WHERE inventory_id = 2476 or inventory_id = 4202 or inventory_id = 3688; # get film_id  542 806 914
SELECT * FROM film WHERE film_id = 542 or film_id = 806 or film_id = 914; # Lust lock, sleepy japanese, trouble date

# excution order in SQL
# from - where - group by - having - select, should use HAVING COUNT(rental_id) 