-- 1. Write a query to display for each store its store ID, city, and country;

SELECT s.store_id, c.city, country.country
FROM sakila.store s
JOIN sakila.address a
ON s.address_id = a.address_id
JOIN sakila.city c
ON a.city_id = c.city_id
JOIN sakila.country
ON c.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, CONCAT('$', FORMAT(SUM(payment.amount), 2))
FROM sakila.store
JOIN sakila.staff
ON store.store_id = staff.store_id
JOIN sakila.payment
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3. Which film categories are longest?

SELECT category.name, SUM(film.length) AS length
FROM sakila.category
JOIN sakila.film_category
ON category.category_id = film_category.category_id
JOIN sakila.film
ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY length DESC
LIMIT 5;

-- 4. Display the most frequently rented movies in descending order.

SELECT film.title, COUNT(inventory.film_id) AS times_rented
FROM sakila.film
JOIN sakila.inventory
ON film.film_id=inventory.film_id
JOIN sakila.rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY times_rented DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT category.name, SUM(payment.amount) AS gross_revenue
FROM sakila.category
JOIN sakila.film_category
ON category.category_id = film_category.category_id
JOIN sakila.film
ON film_category.film_id = film.film_id
JOIN sakila.inventory
ON film.film_id = inventory.film_id
JOIN sakila.rental
ON inventory.inventory_id = rental.inventory_id
JOIN sakila.payment
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1? -- I assume 

SELECT COUNT(film.title) AS number_of_copies
FROM sakila.film
JOIN sakila.inventory
ON film.film_id = inventory.film_id
JOIN sakila.store
ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = '1';


-- 7. Get all pairs of actors that worked together.

SELECT fa1.actor_id, a1.first_name, a1.last_name, fa2.actor_id, a2.first_name, a2.last_name
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON (fa1.actor_id < fa2.actor_id) AND (fa1.film_id = fa2.film_id)
JOIN sakila.actor a1 
ON (fa1.actor_id = a1.actor_id)
JOIN sakila.actor a2 
ON (fa2.actor_id = a2.actor_id);

-- 8. Get all pairs of customers that have rented the same film more than 3 times.

SELECT i.film_id, COUNT(DISTINCT(i.film_id)) AS times_rented
FROM sakila.inventory i
JOIN sakila.rental r
ON i.inventory_id = r.inventory_id
JOIN sakila.customer c1
ON c1.customer_id = r.customer_id
JOIN sakila.customer c2
ON c1.customer_id <> c2.customer_id
GROUP BY i.film_id
HAVING times_rented>3;

-- 9. For each film, list actor that has acted in more films. CHECK


SELECT f.title, fa.actor_id
FROM sakila.film f
JOIN sakila.film_actor fa
ON f.film_id = fa.film_id
JOIN sakila.actor a
ON a.actor_id = fa.actor_id;

SELECT actor_id, COUNT(DISTINCT(film_id)) AS number_of_films
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY number_of_films DESC;


