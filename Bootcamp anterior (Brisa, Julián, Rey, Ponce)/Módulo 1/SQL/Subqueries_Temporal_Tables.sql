CREATE TEMPORARY TABLE sakila.staff_payments
SELECT DISTINCT(st.staff_id), ad.address, st.first_name, st.last_name, st.email, pa.amount, pa.payment_date
FROM sakila.staff st 
LEFT JOIN sakila.payment pa ON st.staff_id = pa.staff_id
INNER JOIN sakila.store so ON  st.store_id = so.store_id
LEFT JOIN sakila.address ad ON so.address_id = ad.address_id; 

-- -------------------------------------------------------------------------------------------------------------------------

SELECT * 
FROM sakila.staff_payments;

-- -------------------------------------------------------------------------------------------------------------------------

SELECT CONCAT(last_name, ' ', first_name) AS 'Name', SUM(amount) 
FROM sakila.staff_payments 
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31'
AND amount > 1
GROUP BY Name; 

-- -------------------------------------------------------------------------------------------------------------------------


SELECT asia.country, COUNT(asia.customer_id), COUNT(DISTINCT asia.city), COUNT(Distinct asia.postal_code)
FROM (
SELECT cu.customer_id, date_format(cu.create_date, '%Y-%m') AS 'Date_register', cu.first_name, cu.last_name, 
ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city, ci.country_id, co.country
FROM sakila.customer cu
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id 
WHERE co.country = 'Japan'

UNION ALL 

SELECT cu.customer_id, date_format(cu.create_date, '%Y-%m') AS 'Date_register', cu.first_name, cu.last_name, 
ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city, ci.country_id, co.country
FROM sakila.customer cu
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id 
WHERE co.country = 'China'

UNION ALL 

SELECT cu.customer_id, date_format(cu.create_date, '%Y-%m') AS 'Date_register', cu.first_name, cu.last_name, 
ad.address_id, ad.address, ad.city_id, ad.postal_code, ci.city, ci.country_id, co.country
FROM sakila.customer cu
LEFT JOIN sakila.address ad ON cu.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id 
WHERE co.country = 'Taiwan' ) asia
GROUP BY country;
