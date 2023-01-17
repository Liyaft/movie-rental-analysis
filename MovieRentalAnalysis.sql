USE sakila;

-- Getting to know the database
-- Aggregate count of the films in database
SELECT COUNT(*) AS 'Total Films'
FROM film;

-- Aggregate count of the films in inventory
SELECT COUNT(*) AS 'Inventory Total'
FROM inventory;

-- Film Count by Category
SELECT name, COUNT(film_id) AS FilmsByCategory
FROM film_category
INNER JOIN category 
ON film_category.category_id = category.category_id
GROUP BY name
ORDER BY FilmsByCategory DESC;

-- Film count by rating 
SELECT rating, COUNT(film_id) AS FilmsByRating
FROM film
GROUP BY rating
ORDER BY FilmsByRating DESC;

-- Film count by language (note consideration of adding more foreign languages)
SELECT name, COUNT(film_id) AS FilmsByLanguage
FROM film
INNER JOIN language
ON film.language_id = language.language_id
GROUP BY name;

-- Getting to know our stores and customers
-- Aggregate count of the customers in database
SELECT COUNT(*) AS 'Customer total'
FROM customer;

-- Count of stores
SELECT COUNT(*) AS 'Store total'
FROM store;

-- Number of active customers
SELECT COUNT(*) 
FROM customer
WHERE active = 1;

-- Information on Active customers
SELECT * 
FROM customer
WHERE active = 1;

-- Which country has the most customers (consider expanding foreign film selection)
SELECT country, COUNT(*) AS CustomersByCountry
FROM address 
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country
ORDER BY CustomersByCountry DESC;

-- Total revenue for each store
SELECT store_id, SUM(amount) AS RevenueByStore
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY payment.staff_id
ORDER BY RevenueByStore DESC;

-- Which store is more popular in terms of customers
SELECT store_id, COUNT(DISTINCT customer.customer_id) AS NumberOfCustomers
FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY store_id;

-- Most popular rentals (consider increasing inventory based on popularity)
SELECT title, COUNT(*) AS TotalRentals
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY TotalRentals DESC;

-- Films in inventory
SELECT title, COUNT(*) AS InventoryByTitle
FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY InventoryByTitle DESC;

-- Information on top customers
SELECT rental.customer_id, customer.first_name, customer.last_name, customer.email, COUNT(rental.rental_id) AS TimesCustomerRented  
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY customer_id
ORDER BY TimesCustomerRented DESC;

-- Information on inactive customers
SELECT rental.customer_id, customer.store_id, customer.first_name, customer.last_name, customer.email
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.active = 0
GROUP BY customer_id;

