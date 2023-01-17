# Analysis of Movie Rental Data Using SQL

## Table of Contents
* [Introduction](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#introduction)
* [The Database](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#the-dataset)
  * [EER Diagram](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#eer-diagram)
  * [Tables](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#tables)
  * [Installation](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#installation)
* [Exploring the Database](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#exploring-the-dataset)
  * [Questions of Interest](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#questions-of-interest)
  * [Getting to Know the Films](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#getting-to-know-the-films)
  * [Getting to Know the Stores and Customers](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#getting-to-know-the-stores-and-customers)
  * [Further Exploration](https://github.com/Liyaft/movie-rental-analysis/edit/main/README.md#further-exploration)

# Introduction
In this project, I analyzed data from a movie rental company. This data was obtained from the Sakila database, which was created by MySQL. Using this data, I created SQL queries to conduct exploratory data analysis and to suggest ways the company can improve.

# The Database
Sakila is a normalized schema that models a movie rental company. The database provides information on the films, inventory, rentals, customers, and stores. More information on the Sakila database can be found [here](https://dev.mysql.com/doc/sakila/en/sakila-introduction.html).

## EER Diagram
<img src="https://user-images.githubusercontent.com/117689127/212949112-c15dfb2b-d59e-456d-87f2-ce3fd2f3f444.png" width="500" height="450">


## Tables
The Sakila database consists of the following 16 tables: 
  * actor 
  * address
  * category
  * city
  * country
  * customer
  * film
  * film_actor 
  * film_category
  * film_text
  * inventory
  * language
  * payment
  * rental
  * staff
  * store

## Installation
The Sakila database can be downloaded [here](https://dev.mysql.com/doc/index-other.html). Additional information on installing the database can be found on the [MySQL documentation site](https://dev.mysql.com/doc/index-other.html).

# Exploring the Database
## Questions of Interest
  * How many active customers does the company have? 
  * Which country has the most customers? 
  * What is the total revenue for each of the stores?
  * Which store is most popular?
  * What are the most popular rentals?
  * Who are the top customers?
  * Which customers are inactive? 

## Getting to Know the Films

To start, we want to get some background information on the films in the database.
```SQL
-- Aggregate count of the films in database
SELECT COUNT(*) AS 'Total Films'
FROM film;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212965408-a6defb4f-ed31-45e9-ae71-0b8f4ad25c06.png">

```SQL
-- Aggregate count of the films in inventory
SELECT COUNT(*) AS 'Inventory Total'
FROM inventory;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212978015-0bbc3edd-25db-41b1-9701-8bb851b0b21f.png">

```SQL
-- Film Count by Category
SELECT name, COUNT(film_id) AS FilmsByCategory
FROM film_category
INNER JOIN category 
ON film_category.category_id = category.category_id
GROUP BY name
ORDER BY FilmsByCategory DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983440-2c9a736c-9dcc-4132-8ee0-b29e649b152d.png">

```SQL
-- Film Count by rating 
SELECT rating, COUNT(film_id) AS FilmsByRating
FROM film
GROUP BY rating
ORDER BY FilmsByRating DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983295-c1fbac9b-fb0c-4b0f-9617-05844438af8f.png">

```SQL
-- Film count by language
SELECT name, COUNT(film_id) AS FilmsByLanguage
FROM film
INNER JOIN language
ON film.language_id = language.language_id
GROUP BY name;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983566-1734ad72-430e-4138-9fa4-c9894b481eb8.png">

## Getting to Know the Stores and Customers
```SQL
-- Aggregate count of the customers in database
SELECT COUNT(*) AS 'Customer total'
FROM customer;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983701-2aab0281-f615-4f6f-8b9b-eef443ab48fc.png">

```SQL
-- Count of stores
SELECT COUNT(*) AS 'Store total'
FROM store;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983766-92b6bd30-c354-4553-adbc-9b2500c1ccb9.png">

```SQL
-- Number of active customers
SELECT COUNT(*) 
FROM customer
WHERE active = 1;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212983981-74573246-e7a9-49a2-b5e4-ef9820fe7e4c.png">

```SQL
-- Information on Active customers
SELECT * 
FROM customer
WHERE active = 1;
```
<img width="400" src="https://user-images.githubusercontent.com/117689127/212984173-71b703f8-647b-4bb7-9123-2379eca223c0.png">

## Further Exploration

```SQL
-- Which country has the most customers
SELECT country, COUNT(*) AS CustomersByCountry
FROM address 
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country
ORDER BY CustomersByCountry DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212984525-5073c891-c2de-4f9e-b624-6c476ce51d05.png">
Based on the results of this query, one recommendation the company should consider is expanding their foreign film collection. In the fourth query, we discovered that all of the films in the database are in English. Now that we have a better understanding of the company's customer base, adding foreign language films could work as a way to appeal to our current customers and attract new ones.

```SQL
-- Total revenue for each store
SELECT store_id, SUM(amount) AS RevenueByStore
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY payment.staff_id
ORDER BY RevenueByStore DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212984648-83e9fb24-2c69-4492-b27d-c7a2650b1437.png">

```SQL 
-- Which store is more popular in terms of customers
SELECT store_id, COUNT(DISTINCT customer.customer_id) AS NumberOfCustomers
FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY store_id;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212984730-f93e8f04-9bc1-4894-885d-ca35e7bce089.png">

```SQL 
-- Most popular rentals (consider increasing inventory based on popularity)
SELECT title, COUNT(*) AS TotalRentals
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY TotalRentals DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212985104-01f2f570-4140-4fe4-83f8-846f4daa8cde.png">

```SQL 
-- Films in inventory
SELECT title, COUNT(*) AS InventoryByTitle
FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY InventoryByTitle DESC;
```
<img width="200" src="https://user-images.githubusercontent.com/117689127/212986195-87038797-a8e3-415b-9afe-d0761c677277.png">

```SQL 
-- Information on top customers
SELECT rental.customer_id, customer.first_name, customer.last_name, customer.email, COUNT(rental.rental_id) AS TimesCustomerRented  
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY customer_id
ORDER BY TimesCustomerRented DESC;
```
<img width="400" src="https://user-images.githubusercontent.com/117689127/212986329-b67c4a15-c7cf-4a78-b98a-df30bca41732.png">

```SQL 
-- Information on inactive customers
SELECT rental.customer_id, customer.store_id, customer.first_name, customer.last_name, customer.email
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.active = 0
GROUP BY customer_id;
```
<img width="400" src="https://user-images.githubusercontent.com/117689127/212986494-2f019d31-9be5-47cc-a0cf-833fb353f32f.png">
Based on the information we've gathered on active and inactive customers, the company should consider reaching out to these customers. One recommendation is to begin an email marketing campaign in order to boost customer retention. This could be done by targeting customers who are inactive or at risk of becoming inactive. A customer loyalty program, which is aimed at the top active customers could also be used as a customer retention strategy. 
