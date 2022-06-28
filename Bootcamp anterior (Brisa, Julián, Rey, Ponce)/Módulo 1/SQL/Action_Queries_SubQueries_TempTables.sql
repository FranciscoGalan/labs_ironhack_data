CREATE TABLE sakila.count_rent_film
SELECT re.rental_id, fi.title, COUNT(DISTINCT re.rental_id) 
FROM sakila.film AS fi
INNER JOIN sakila.inventory AS inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental AS re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title; 

SELECT * 
FROM sakila.count_rent_film;

DROP TABLE sakila.count_rent_film; 

CREATE TABLE sakila.count_rent_film
SELECT fi.title, COUNT(re.rental_id) as 'times_rented',
COUNT(DISTINCT cu.customer_id) as 'number_of_customers_rented'
FROM sakila.film fi
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id 
LEFT JOIN sakila.customer cu ON re.customer_id = cu.customer_id
GROUP BY fi.title; 

-- ----------------------------------------------------------------------
# Esto es un comentario

/* */

SELECT * 
FROM sakila.count_rent_film;

-- ----------------------------------------------------------------------
USE sakila; 


-- EXPLAIN 
CREATE TABLE sakila.customer_data
SELECT DISTINCT(cu.customer_id), DATE_FORMAT(cu.create_date, '%Y-%m') AS 'date_register', 
cu.first_name, cu.last_name, ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city,
ci.country_id, co.country
FROM sakila.customer cu 
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id 
LEFT JOIN sakila.country co ON  ci.country_id = co.country_id; 

SELECT *
FROM sakila.customer_data; 

SELECT distinct(country)
FROM sakila.customer_data; 

DELETE FROM sakila.customer_data
WHERE country IN ('Chile', 'Madagascar', 'Brunei', 'Israel', 'Yemen');

SELECT * 
FROM sakila.customer_data 
WHERE country = 'Chile';


SELECT e.title, SUM(total_amount) AS 'total_amount'
FROM (
SELECT d.title, d.times_rented * pa.amount as 'total_amount' 
FROM (
SELECT re.rental_id, fi.title, COUNT(re.rental_id) as 'times_rented'
FROM sakila.film fi 
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title) AS d 
LEFT JOIN sakila.payment pa ON d.rental_id = pa.rental_id) AS e
GROUP BY e.title
ORDER BY total_amount DESC; 


CREATE TEMPORARY TABLE sakila.film_rent_revenue
SELECT e.title, SUM(total_amount) AS 'total_amount'
FROM (
SELECT d.title, d.times_rented * pa.amount as 'total_amount' 
FROM (
SELECT re.rental_id, fi.title, COUNT(re.rental_id) as 'times_rented'
FROM sakila.film fi 
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title) AS d 
LEFT JOIN sakila.payment pa ON d.rental_id = pa.rental_id) AS e
GROUP BY e.title
ORDER BY total_amount DESC; 

SELECT *
FROM sakila.film_rent_revenue;

UPDATE sakila.film_rent_revenue
SET total_amount = total_amount - 100
WHERE codigo_descuento = 'CUPON100'; 

SELECT *
FROM sakila.film_rent_revenue;

INSERT INTO sakila.film_rent_revenue (title, total_amount)
VALUES ('Lord of the Rings', 3512340.00); 

SELECT *
FROM sakila.film_rent_revenue
ORDER BY total_amount DESC;

