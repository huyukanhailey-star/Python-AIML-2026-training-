# 1. display all customer details who have made more than 5 payments.
SELECT * FROM payment;
SELECT * FROM customer; # use inner join, customer_id is the unique identifier
SELECT c.customer_id, c.store_id, c.first_name,c.last_name, c.email,c. address_id,c.active,c. create_date,c.last_update
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT(p.customer_id) > 5;

# 2. Find the names of actors who have acted in more than 10 films.
SELECT * FROM film_actor;
SELECT * FROM actor; # use inner join, actor_id is the unique identifier
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.actor_id) > 10;

# 3. Find the names of customers who never made a payment.
SELECT * FROM payment;
SELECT * FROM customer; 
SELECT c.customer_id, c.first_name,c.last_name
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.customer_id is null
GROUP BY c.customer_id;

# 4. List all films whose rental rate is higher than the average rental rate of all films.
SELECT film_id, title,rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
)
ORDER BY rental_rate DESC;

# 5. List the titles of films that were never rented.
SELECT * FROM rental; # inventory_id
SELECT * FROM inventory; # inventory_id, film_id
SELECT * FROM film; # film_id
SELECT f.title, f.film_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r. rental_id is null; 

# 6. Display the customers who rented films in the same month as customer with ID 5.
SELECT * FROM customer WHERE customer_id = 5;
SELECT * FROM rental WHERE customer_id = 5;
SELECT MONTH(rental_date) FROM rental WHERE customer_id = 5;
SELECT customer_id, rental_date
FROM rental
WHERE MONTH(rental_date) IN (
	SELECT MONTH(rental_date) 
    FROM rental WHERE customer_id = 5); # weird, only showing May

# 7. Find all staff members who handled a payment greater than the average payment amount.
SELECT * FROM payment;
SELECT staff_id,amount
FROM payment
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
    )
ORDER BY amount DESC;

# 8. Show the title and rental duration of films whose rental duration is greater than the average.
SELECT * FROM film;
SELECT title,rental_duration
FROM film
WHERE rental_duration > (
	SELECT AVG(rental_duration)
    FROM film
    )
ORDER BY rental_duration DESC;

# 9. Find all customers who have the same address as customer with ID 1.
SELECT * FROM customer WHERE customer_id = 1; # address_id=5
SELECT customer_id, first_name, last_name, address_id
FROM customer
WHERE address_id = (
    SELECT address_id FROM customer WHERE customer_id = 1
);

# 10. List all payments that are greater than the average of all payments.
SELECT * FROM payment;
SELECT payment_id,amount
FROM payment
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
    )
ORDER BY amount DESC;

-- SQL JOIN QUESTIONS 

# 1. List all customers along with the films they have rented.
SELECT * FROM customer; # customer_id
SELECT * FROM rental; #inventory_id, customer_id
SELECT * FROM inventory; #inventory_id, film_id

SELECT c.customer_id, c.first_name, c.last_name, i.film_id, f.title
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON  r.inventory_id = i.inventory_id
LEFT JOIN film f ON i. film_id = f. film_id;

# 2. List all customers and show their rental count, including those who haven't rented any films
SELECT * FROM customer; # customer_id
SELECT * FROM rental; #customer_id
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS rentalcount
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

# 3. Show all films along with their category. Include films that don't have a category assigned.
SELECT * FROM film_category;
SELECT * FROM category;
SELECT f.film_id, f.title, fc.category_id, c.name
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON c.category_id = fc.category_id;

# 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
SELECT * FROM customer;
SELECT * FROM staff;
SELECT c.email, f.email
FROM customer c
LEFT JOIN staff f ON c.store_id = f.store_id
UNION
SELECT c.email, f.email
FROM customer c
RIGHT JOIN staff f ON c.store_id = f.store_id;

# 5. Find all actors who acted in the film "ACADEMY DINOSAUR".
SELECT * FROM film_actor;
SELECT * FROM film WHERE title = "ACADEMY DINOSAUR"; # film_id = 1
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE film_id = (
	SELECT film_id FROM film WHERE title = "ACADEMY DINOSAUR"
    );

# 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
SELECT * FROM store;
SELECT * FROM staff;
SELECT s.store_id,  COUNT(sf.store_id) AS staffcount
FROM store s 
LEFT JOIN staff sf ON s.store_id = sf.store_id
GROUP BY s.store_id;

# 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
SELECT * FROM customer; # customer_id
SELECT * FROM rental; #customer_id
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS rentalcount
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.customer_id)>5;