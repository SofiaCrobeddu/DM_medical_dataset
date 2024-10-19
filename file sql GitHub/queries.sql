-- Data Management for Data Science: Homework 1-2
-- GROUP 25: Stefano Rinaldi (mtr. 1945551) and Sofia Noemi Crobeddu (mtr. 2130389)
-- Dataset: Open Drug Knowledge Graph

-- 1) Which are the products with an average number of reviews higher than 1000 and which is their type (RX for Prescription or OTC for Over-the-Counter)?
SELECT prod.name AS product_name, prod.type, AVG(prod.n_reviews) AS avg_reviews
FROM product prod
WHERE prod.drug_id IN(
        SELECT d.id
        FROM drug d
        WHERE d.id IS NOT NULL
)
GROUP BY product_name, prod.type
HAVING AVG(prod.n_reviews) > 1000
ORDER BY AVG(prod.n_reviews) DESC;

-- Note: The products with OTC type don’t need prescription by doctors. The output shows that the majority (especially analyzing the first ten products) 
-- deal with problems of depression, anxiety, panic attack and epilepsy. Then these results suggest that mental illness would be interesting to analyze 
-- from this data. It is the reason why in question 6) we searched for products that deal with ‘anxiety’.


-- 2) Which is the most frequent drug sold and used?
SELECT d.name, d.id
FROM drug d
WHERE d.id IN (
    SELECT drug_id 
    FROM( 
        SELECT drug_id
        FROM product
        GROUP BY drug_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);


-- 3) Which are the prices or the price's range of the most used drug?
SELECT MIN(p.price) AS min_price, MAX(p.price) AS max_price, COUNT(p.product_id) AS product_count
FROM price p
WHERE p.product_id IN(
    SELECT prod.id
    FROM product prod
    WHERE prod.drug_id = 'DB00741');


-- 4) Which are the conditions treated by the most used drug?
SELECT COUNT(t.condition_id) AS frequency, (SELECT cdt.name
                                            FROM condition cdt
                                            WHERE cdt.id=t.condition_id
                            ) AS condition_name
FROM treatment t
WHERE  t.drug_id='DB00741'
GROUP BY condition_name
ORDER BY frequency DESC, condition_name;


-- 5) Which are the drugs' names to treat COVID-19?
SELECT d.name
FROM drug d
WHERE d.id IN (
    SELECT t.drug_id
    FROM treatment t
    WHERE t.condition_id IN (
        SELECT id
        FROM condition
        WHERE name = 'COVID-19'
    )
)
GROUP BY d.name;

-- Note: we decided to analyze COVID-19 since it is a really important part of our human history. To add some information about the outputs: 
-- the effect of Dexamethasone was also analyzed through the investigation ‘RECOVERY’, conducted by the European Medicines Agency (EMA) in the UK in 2020. 
-- The result was that this drug reduced the mortality of COVID-19 patients for 35%. To give completeness of information, this is the useful link for a small 
-- part of the report (in italian): EMA endorses use of dexamethasone in COVID-19 patients on oxygen or mechanical ventilation (aifa.gov.it).


-- 6) Which are the medical products to treat anxiety?
SELECT prod.drug_id, prod.name AS product_name
FROM product prod 
WHERE prod.drug_id IN (
    SELECT t.drug_id
    FROM treatment t
    WHERE t.condition_id IN (
        SELECT cdt.id
        FROM condition cdt
        WHERE cdt.name LIKE '%anxiety%'
    )
)
GROUP BY prod.drug_id, product_name
ORDER BY product_name;


-- 7) Which is the drug prescribed for the highest number of conditions?
SELECT drug_id, COUNT(condition_id) AS num_conditions
FROM treatment
GROUP BY drug_id
HAVING COUNT(condition_id) = (
    SELECT MAX(condition_count)
    FROM (
        SELECT COUNT(condition_id) AS condition_count
        FROM treatment
        GROUP BY drug_id
    ) AS max_conditions
);


-- 8) Which drug(s) cost(s) between 30 and 40 US$?
SELECT p.name, AVG(pr.price) AS avg_price
FROM product p
JOIN (
    SELECT DISTINCT product_id
    FROM price
) AS price_ids
ON p.id = price_ids.product_id
JOIN price pr
ON p.id = pr.product_id
GROUP BY p.name
ORDER BY avg_price DESC;


-- 9) Which is the store that sells the greatest number of drugs?
SELECT store_id, COUNT(*) AS occurrences
FROM price
GROUP BY store_id
ORDER BY occurrences DESC;

SELECT name
FROM store
WHERE id = 3;


-- 10) Which is the total number of drugs for each condition?
-- (implementation of the structure query 9)
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
(very similar in the structure to 9 and 10)
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

-- NOTE: for queries 9,10,11 we did not implement a straightforward query on purpose in order to exploit as many different constructions as possible. 
-- You will see that the implementation of query 9 is the starting point of query 10 and so on.