-- Our SQL code for the queries’ optimization with indexes in some cases (Assignment 2) compared to un-optimized one (Assignment 1) is the following:

-- 1) Which are the products with an average number of reviews higher than 1000 and which is their type (RX for Prescription or OTC for Over-the-Counter)?
SELECT prod.name AS product_name, prod.type, AVG(prod.n_reviews) AS avg_reviews
FROM product prod
JOIN drug d ON prod.drug_id = d.id
WHERE d.id IS NOT NULL
GROUP BY product_name, prod.type
HAVING AVG(prod.n_reviews) > 1000
ORDER BY avg_reviews DESC;


-- 2) Which is the most frequent drug sold and used?
SELECT d.name, d.id
FROM drug d
JOIN(
        SELECT drug_id, count(drug_id) AS freq
        FROM product 
        GROUP BY drug_id
        ORDER BY freq DESC
        LIMIT 1
) AS subpart ON d.id=subpart.drug_id;


-- 3) Which are the prices or the price's range of the most used drug?
CREATE INDEX idx_prod_drug_id ON product(drug_id);

SELECT MIN(p.price) AS min_price, MAX(p.price) AS max_price, COUNT(p.product_id)
FROM price p
JOIN product prod ON p.product_id=prod.id
WHERE prod.drug_id='DB00741';


-- 4) Which are the conditions treated by the most used drug?
CREATE INDEX idx_treat_drug_id ON treatment(drug_id);

SELECT COUNT(t.condition_id) AS frequency, cdt.name AS condition_name
FROM treatment t
JOIN condition cdt ON t.condition_id = cdt.id
WHERE t.drug_id = 'DB00741'
GROUP BY cdt.name
ORDER BY frequency DESC, cdt.name;


-- 5) Which are the drugs' names to treat COVID-19?
CREATE INDEX idx_cond_name ON condition(name);

SELECT d.name
FROM drug d
JOIN treatment t ON d.id=t.drug_id
JOIN condition cdt ON t.condition_id=cdt.id
WHERE cdt.name='COVID-19'
GROUP BY d.name;


-- 6) Which are the medical products to treat anxiety?
-- Note: the index exploited in assignment 2 is the same that we created in 5.
CREATE INDEX idx_cond_name ON condition(name); 

SELECT prod.drug_id, prod.name AS product_name
FROM product prod 
JOIN treatment t ON prod.drug_id = t.drug_id
JOIN condition cdt ON t.condition_id = cdt.id
WHERE cdt.name LIKE '%anxiety%'
GROUP BY prod.drug_id, product_name
ORDER BY product_name;

-- 7) Which is the drug prescribed for the highest number of conditions?
SELECT drug_id, COUNT(condition_id) AS num_conditions
FROM treatment
GROUP BY drug_id
ORDER BY num_conditions DESC
LIMIT 1;


-- 8) Which is the average price of each drug in descending order?
SELECT p.name, AVG(pr.price) AS avg_price
FROM product p
JOIN price pr ON p.id = pr.product_id
GROUP BY p.name
ORDER BY avg_price DESC;


-- 9) Which is the store that sells the greatest number of drugs?
-- The optimization is made using just 1 step.
SELECT name
FROM store
WHERE id = (
    SELECT store_id
    FROM price
    GROUP BY store_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- 10) Which is the total number of drugs for each condition?
-- (implementation of the structure query 9)
CREATE INDEX idx_condition_id ON treatment (condition_id);

SELECT name
FROM condition
WHERE id = (
    SELECT condition_id
    FROM treatment
    GROUP BY condition_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- 11) Which is the manufacturer which manufactures the majority of drugs?
-- (very similar in the structure to 9 and 10)
CREATE INDEX idx_manufacturer_id ON product (manufacturer_id);

SELECT m.name
FROM manufacturer m
JOIN (
    SELECT manufacturer_id, COUNT(*) AS drug_count
    FROM product
    GROUP BY manufacturer_id
    ORDER BY COUNT(*) DESC
) AS max_drug_count
ON m.id = max_drug_count.manufacturer_id
ORDER BY max_drug_count.drug_count DESC;


-- NOTE: the numbers below each table is the last running time of each query, comparing the time of the two.
-- NOTE: Even though our dataset has many tables, it is quite small. This is the main reason for the very fast execution of the queries and the small 
-- time differences between optimized queries and un-optimized ones.