/*
Vamos a ver cuatro cosas en esta clase: 
- Crear tablas 
- Añadir datos a una tabla
- Elimininar datos de una tabla 
- Actualizar datos 

*/
# Lo primero que vamos a ver es como crear nuevas tablas a partir de un query 
# Este query está mal construido a propósito para poder revisar como eliminar una tabla completamente

CREATE TABLE sakila.count_rent_films
SELECT re.rental_id, fi.title, COUNT(rental_id)
FROM sakila.film fi
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title; 

-- -------------------------------------------------------------------------------------------------------------------------

DROP TABLE sakila.count_rent_films;

-- -------------------------------------------------------------------------------------------------------------------------

DELETE FROM sakila.count_rent_films;

-- -------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sakila.count_rent_films
SELECT fi.title, COUNT(re.rental_id) as 'times_rented', COUNT(DISTINCT cu.customer_id) as 'Number_of_customers_rented'
FROM sakila.film fi
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
LEFT JOIN sakila.customer cu ON re.customer_id = cu.customer_id
GROUP BY fi.title;

-- -------------------------------------------------------------------------------------------------------------------------
SELECT d.title, SUM(d.Total_amount) 'Total_amount'
FROM (
SELECT c.title, c.times_rented * pa.amount as 'Total_amount'
FROM (
SELECT re.rental_id, fi.title, COUNT(re.rental_id) as 'times_rented'
FROM sakila.film fi
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title) c
LEFT JOIN sakila.payment pa ON c.rental_id = pa.rental_id) d
GROUP BY d.title
ORDER BY Total_amount DESC; 

-- -------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sakila.film_rent_revenue
SELECT d.title, SUM(d.Total_amount) 'Total_amount'
FROM (
SELECT c.title, c.times_rented * pa.amount as 'Total_amount'
FROM (
SELECT re.rental_id, fi.title, COUNT(re.rental_id) as 'times_rented'
FROM sakila.film fi
INNER JOIN sakila.inventory inv ON fi.film_id = inv.film_id
LEFT JOIN sakila.rental re ON inv.inventory_id = re.inventory_id
GROUP BY re.rental_id, fi.title) c
LEFT JOIN sakila.payment pa ON c.rental_id = pa.rental_id) d
GROUP BY d.title
ORDER BY Total_amount DESC; 

-- -------------------------------------------------------------------------------------------------------------------------
EXPLAIN
SELECT DISTINCT(cu.customer_id), date_format(cu.create_date, '%Y-%m') AS 'Date_register', cu.first_name, cu.last_name, 
ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city, ci.country_id, co.country
FROM sakila.customer cu
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id;

-- -------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sakila.customer_data 
SELECT DISTINCT(cu.customer_id), date_format(cu.create_date, '%Y-%m') AS 'Date_register', cu.first_name, cu.last_name, 
ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city, ci.country_id, co.country
FROM sakila.customer cu
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id;

-- -------------------------------------------------------------------------------------------------------------------------

SELECT * 
FROM sakila.customer_data;

-- -------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT(country)
FROM sakila.customer_data;

-- -------------------------------------------------------------------------------------------------------------------------

DELETE FROM sakila.customer_data
WHERE country in ('Chile', 'Madagascar', 'Brunei', 'Israel', 'Yemen');

-- -------------------------------------------------------------------------------------------------------------------------

SELECT * 
FROM sakila.customer_data
WHERE country = 'Yemen';

-- -------------------------------------------------------------------------------------------------------------------------

UPDATE sakila.film_rent_revenue
SET Total_amount = Total_amount * 1000;

-- -------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM sakila.film_rent_revenue;

-- -------------------------------------------------------------------------------------------------------------------------

INSERT INTO sakila.film_rent_revenue (title, Total_amount) 
VALUES ('STAR WARS', 3523018.00);

-- -------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM sakila.film_rent_revenue
ORDER BY Total_amount DESC;


