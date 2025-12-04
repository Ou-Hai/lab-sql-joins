USE sakila;
-- 1
SELECT 
    c.name AS category_name,
    COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.category_id,c.name
ORDER BY number_of_films DESC;

-- 2
SELECT 
     st.store_id,
     ci.city,
     co.country
FROM store AS st
JOIN address AS ad
     ON st.address_id=ad.address_id
JOIN city AS ci
     ON ad.city_id= ci.city_id
JOIN country AS co
     ON ci.country_id= co.country_id
ORDER BY st.store_id ;
-- 3
SELECT 
    st.store_id,
    SUM(p.amount) AS total_revenue
FROM store AS st
JOIN customer AS cu
    ON st.store_id = cu.store_id
JOIN payment AS p
    ON cu.customer_id = p.customer_id
GROUP BY st.store_id;

-- 4
SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length),2) AS avg_length
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 5
SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length),2) AS avg_length
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 1;

-- 6
SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 10;

-- 7
SELECT
    f.title,
    COUNT(i.inventory_id) AS copies_in_store_1
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
GROUP BY f.title;

-- 8

SELECT
    f.title,
    CASE 
        WHEN IFNULL(COUNT(i.inventory_id), 0) = 0 
            THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;